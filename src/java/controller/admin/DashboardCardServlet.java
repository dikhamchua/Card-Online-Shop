package controller.admin;

import dal.implement.CardDAO;
import dal.implement.CardTypeDAO;
import dal.implement.CardType_PriceDAO;
import entity.Cards;
import entity.CardTypes;
import entity.CardType_Price;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import com.google.gson.Gson;
import controller.user.Constant;
import dal.implement.PriceDAO;
import entity.Price;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.InputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.poi.openxml4j.exceptions.NotOfficeXmlFileException;
import org.apache.poi.poifs.filesystem.OfficeXmlFileException;

@MultipartConfig
public class DashboardCardServlet extends HttpServlet {

    PriceDAO priceDAO = new PriceDAO();
    CardDAO cardDAO = new CardDAO();
    CardTypeDAO cardTypeDAO = new CardTypeDAO();
    CardType_PriceDAO cardTypePriceDAO = new CardType_PriceDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String action = request.getParameter("action") == null ? "" : request.getParameter("action");

        switch (action) {
            case "getPricesByCardType":
                getPricesByCardType(request, response);
                return;
            default:
                String keyword = request.getParameter("keyword");
                List<Cards> listProduct;

                // Perform search
                if (keyword != null && !keyword.isEmpty()) {
                    listProduct = cardDAO.findByKeyword(keyword);
                } else {
                    listProduct = cardDAO.findAllDesc(); // Sử dụng phương thức findAllDesc để lấy danh sách từ mới nhất
                }
                String pageRaw = request.getParameter("page");
                int page;
                try {
                    page = Integer.parseInt(pageRaw);
                    if (page <= 0) {
                        page = 1;
                    }
                } catch (NumberFormatException e) {
                    page = 1;
                }

                int recordPerPage = Constant.RECORD_PER_PAGE;

                // Set paginated listProduct
                int totalRecordProduct = listProduct.size();
                int totalPageProduct = (totalRecordProduct % recordPerPage) == 0
                        ? (totalRecordProduct / recordPerPage)
                        : (totalRecordProduct / recordPerPage) + 1;

                int startProduct = (page - 1) * recordPerPage;
                int endProduct = Math.min(startProduct + recordPerPage, totalRecordProduct);
                List<Cards> paginatedListProduct = listProduct.subList(startProduct, endProduct);

                // Tính toán các trang để hiển thị
                int beginPage = Math.max(1, page - 2);
                int endPage = Math.min(totalPageProduct, page + 2);

                if (page > 3) {
                    beginPage = Math.max(1, beginPage); // Always show at least the first page
                }

                if (endPage < totalPageProduct - 1) {
                    endPage = Math.min(totalPageProduct, endPage); // Always show at least the last page
                }

                //get data
                List<CardType_Price> listCardType_Price = cardTypePriceDAO.findAll();
                List<CardTypes> listCardTypes = cardTypeDAO.findAll();
                List<Price> listPrices = priceDAO.findAll();

                //set vào request
                request.setAttribute("listProduct", paginatedListProduct);
                request.setAttribute("totalPageProduct", totalPageProduct);
                request.setAttribute("currentPage", page);
                request.setAttribute("beginPage", beginPage);
                request.setAttribute("endPage", endPage);
                request.setAttribute("keyword", keyword);
                request.setAttribute("listCardTypes", listCardTypes);
                request.setAttribute("listCardType_Price", listCardType_Price);
                request.setAttribute("listPrices", listPrices);
                request.getRequestDispatcher("../view/admin/dashboardProduct.jsp").forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        String action = request.getParameter("action") == null ? "" : request.getParameter("action");
        switch (action) {
            case "add": {
                try {
                    addProduct(request, response);
                } catch (ParseException ex) {
                    Logger.getLogger(DashboardCardServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
                break;
            }
            case "delete":
                delete(request, response);
                response.sendRedirect(request.getContextPath() + "/admin/dashboardcard");
                break;
            case "checkSerialNumber":
                checkSerialNumber(request, response);
                return;
            case "checkCardCode":
                checkCardCode(request, response);
                return;
            case "checkExpirationDate":
                checkExpirationDate(request, response);
                return;
            case "uploadExcel":
                uploadExcel(request, response);
                return;  // Remove redirect here to stay on the same page
            default:
                response.sendRedirect(request.getContextPath() + "/admin/dashboardcard");
        }
    }

    private void addProduct(HttpServletRequest request, HttpServletResponse response) throws IOException, ParseException {
        String cardcode = request.getParameter("cardcode");
        String serialnumber = request.getParameter("serialnumber");
        int cardtypeid = Integer.parseInt(request.getParameter("cardtypeid"));
        int priceid = Integer.parseInt(request.getParameter("price"));
        String expirationDateStr = request.getParameter("expirationDate");

        Date expirationDate = null;
        try {
            expirationDate = new SimpleDateFormat("yyyy-MM-dd").parse(expirationDateStr);
        } catch (ParseException e) {
            e.printStackTrace();
        }

        if (expirationDate != null && expirationDate.before(new Date())) {
            response.setContentType("text/html; charset=UTF-8");
            try (PrintWriter out = response.getWriter()) {
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Không được thêm thẻ đã qua hạn sử dụng');");
                out.println("history.back();");
                out.println("</script>");
            }
            return;
        }

        CardType_Price cardTypePrice = cardTypePriceDAO.findByCardTypeIdAndPriceId(cardtypeid, priceid);

        if (cardTypePrice != null) {
            Cards card = Cards.builder()
                    .CardCode(cardcode)
                    .SerialNumber(serialnumber)
                    .CardType_Price(cardTypePrice.getID())
                    .ExpirationDate(new java.sql.Date(expirationDate.getTime()))
                    .Status("Available")
                    .build();
            cardDAO.insert(card);

            // Gửi phản hồi JSON thành công
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            PrintWriter out = response.getWriter();
            out.write("{\"status\":\"success\",\"message\":\"Thêm thẻ thành công! Mã thẻ: " + cardcode + ", Số seri: " + serialnumber + ", Ngày hết hạn: " + expirationDateStr + "\"}");
            out.flush();
        } else {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            PrintWriter out = response.getWriter();
            out.write("{\"status\":\"error\",\"message\":\"Không tìm thấy loại thẻ hoặc mệnh giá phù hợp\"}");
            out.flush();
        }
    }

    private void delete(HttpServletRequest request, HttpServletResponse response) {
        int ID = Integer.parseInt(request.getParameter("ID"));
        cardDAO.deleteById(ID);
    }

    private void checkSerialNumber(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String serialnumber = request.getParameter("serialnumber");
        boolean exists = cardDAO.serialNumberExists(serialnumber);

        try (PrintWriter out = response.getWriter()) {
            if (exists) {
                out.print("exists");
            } else {
                out.print("not exists");
            }
        }
    }

    private void checkCardCode(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String cardcode = request.getParameter("cardcode");
        boolean exists = cardDAO.cardCodeExists(cardcode);

        try (PrintWriter out = response.getWriter()) {
            if (exists) {
                out.print("exists");
            } else {
                out.print("not exists");
            }
        }
    }

    private void checkExpirationDate(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String expirationDateStr = request.getParameter("expirationDate");

        // Chuyển đổi expirationDate từ String sang Date
        Date expirationDate = null;
        try {
            expirationDate = new SimpleDateFormat("yyyy-MM-dd").parse(expirationDateStr);
        } catch (ParseException e) {
            e.printStackTrace();
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Kiểm tra xem thẻ có bị hết hạn hay không
        if (expirationDate != null && expirationDate.before(new Date())) {
            // Thông báo lỗi nếu thẻ đã hết hạn
            response.getWriter().write("{\"status\":\"error\",\"message\":\"Không được thêm thẻ đã qua hạn sử dụng\"}");
        } else {
            response.getWriter().write("{\"status\":\"success\"}");
        }
    }

    private void getPricesByCardType(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int cardtypeid = Integer.parseInt(request.getParameter("cardtypeid"));
        List<Map<String, Object>> pricesData = new ArrayList<>();

        List<CardType_Price> cardTypePrices = cardTypePriceDAO.findByCardTypeId(cardtypeid);
        for (CardType_Price ctp : cardTypePrices) {
            Map<String, Object> priceData = new HashMap<>();
            priceData.put("ID", ctp.getPriceID());

            // Lấy giá thực tế từ bảng Price
            Price price = priceDAO.findById(ctp.getPriceID());
            if (price != null) {
                priceData.put("Price", price.getPrice());
            } else {
                priceData.put("Price", 0);
            }

            pricesData.add(priceData);
        }

        Gson gson = new Gson();
        String json = gson.toJson(pricesData);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
    }

    private void uploadExcel(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        StringBuilder errorMessage = new StringBuilder();
        StringBuilder successMessage = new StringBuilder();
        try {
            Part filePart = request.getPart("excelFile");
            String fileName = filePart.getSubmittedFileName();
            InputStream fileContent = filePart.getInputStream();
            Workbook workbook = null;
            if (fileName.endsWith(".xlsx")) {
                workbook = new XSSFWorkbook(fileContent);
            } else if (fileName.endsWith(".xls")) {
                workbook = new HSSFWorkbook(fileContent);
            }
            if (workbook != null) {
                Sheet sheet = workbook.getSheetAt(0);
                for (Row row : sheet) {
                    if (row.getRowNum() == 0) {
                        continue;
                    }
                    String cardcode = getCellValueAsString(row.getCell(0));
                    String serialnumber = getCellValueAsString(row.getCell(1));
                    int cardtypeid = getCellValueAsInt(row.getCell(2));
                    int priceid = getCellValueAsInt(row.getCell(3));
                    String expirationDateStr = getCellValueAsString(row.getCell(4));
                    Date expirationDate = null;
                    try {
                        expirationDate = new SimpleDateFormat("dd/MM/yyyy").parse(expirationDateStr);
                    } catch (ParseException e) {
                        errorMessage.append("").append(cardcode).append("");
                        continue;
                    }

                    if (expirationDate != null && expirationDate.before(new Date())) {
                        errorMessage.append("Card with code ").append(cardcode).append(" has expired.<br>");
                        continue;
                    }

                    CardType_Price cardTypePrice = cardTypePriceDAO.findByCardTypeIdAndPriceId(cardtypeid, priceid);
                    if (cardTypePrice != null) {
                        if (cardDAO.cardCodeExists(cardcode) || cardDAO.serialNumberExists(serialnumber)) {
                            errorMessage.append("Card with code ").append(cardcode).append(" or serial number ").append(serialnumber).append(" already exists.<br>");
                        } else {
                            Cards card = Cards.builder()
                                    .CardCode(cardcode)
                                    .SerialNumber(serialnumber)
                                    .CardType_Price(cardTypePrice.getID())
                                    .ExpirationDate(new java.sql.Date(expirationDate.getTime()))
                                    .Status("Available")
                                    .build();
                            cardDAO.insert(card);
                            successMessage.append("Added card successfully! Code: ").append(cardcode).append(", Serial: ").append(serialnumber).append(", Expiry: ").append(expirationDateStr).append("<br>");
                        }
                    } else {
                        errorMessage.append("").append(cardcode).append("");
                    }
                }
                workbook.close();
            }
            session.setAttribute("errorMessageExcel", errorMessage.toString());
            session.setAttribute("successMessageExcel", successMessage.toString());
            session.setAttribute("showExcelModal", true);
            response.sendRedirect(request.getContextPath() + "/admin/dashboardcard");
        } catch (Exception e) {
            session.setAttribute("errorMessageExcel", "Invalid format, addition failed.");
            session.setAttribute("showExcelModal", true);
            response.sendRedirect(request.getContextPath() + "/admin/dashboardcard");
        }
    }

    private String getCellValueAsString(Cell cell) {
        if (cell == null) {
            return "";
        }
        CellType cellType = cell.getCellTypeEnum();
        if (cellType == CellType.STRING) {
            return cell.getStringCellValue();
        } else if (cellType == CellType.NUMERIC) {
            return String.valueOf((int) cell.getNumericCellValue());
        } else {
            return "";
        }
    }

    private int getCellValueAsInt(Cell cell) {
        if (cell == null) {
            return 0;
        }
        CellType cellType = cell.getCellTypeEnum();
        if (cellType == CellType.NUMERIC) {
            return (int) cell.getNumericCellValue();
        } else {
            return 0;
        }
    }
}
