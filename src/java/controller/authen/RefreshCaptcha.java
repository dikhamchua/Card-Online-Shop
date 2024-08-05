/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.authen;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.imageio.ImageIO;

public class RefreshCaptcha extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/plain");
        int width = 205;
        int height = 55;
        BufferedImage bufferedImage = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        Graphics g = bufferedImage.getGraphics();

        g.setColor(Color.LIGHT_GRAY);
        g.fillRect(0, 0, width, height);

        Random random = new Random();
        g.setColor(Color.BLACK);
        for (int i = 0; i < 15; i++) {
            int x1 = random.nextInt(width);
            int y1 = random.nextInt(height);
            int x2 = random.nextInt(width);
            int y2 = random.nextInt(height);
            g.drawLine(x1, y1, x2, y2);
        }

        g.setFont(new Font("Arial", Font.BOLD, 40));
        String captcha = generateCaptcha();

        HttpSession session = request.getSession();
        session.setAttribute("captcha", captcha);

        g.setColor(Color.BLACK);
        g.drawString(captcha, 20, 35);
        g.dispose();

        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        try {
            ImageIO.write(bufferedImage, "png", baos);
        } catch (IOException ex) {
            Logger.getLogger(AuthenticationController.class.getName()).log(Level.SEVERE, null, ex);
        }
        byte[] imageBytes = baos.toByteArray();
        String base64Image = java.util.Base64.getEncoder().encodeToString(imageBytes);
        session.setAttribute("captchaImage", base64Image);

        try {
            response.getWriter().write(base64Image);
        } catch (IOException ex) {
            Logger.getLogger(AuthenticationController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    private String generateCaptcha() {
        // Tạo captcha ngẫu nhiên
        String captcha = "";
        for (int i = 0; i < 5; i++) {
            int random = (int) (Math.random() * 36); // Use 36 to include numbers and uppercase letters
            if (random < 10) {
                captcha += random;
            } else {
                captcha += (char) (random - 10 + 'A');
            }

        }
        return captcha;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet RefreshCaptcha</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RefreshCaptcha at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

}
