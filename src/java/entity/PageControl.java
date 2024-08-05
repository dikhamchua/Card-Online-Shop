package entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@ToString
@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class PageControl {

    private int totalPage;
    private int totalRecord;
    private int page;
    private int pageSize;
    private int startItem;
    private int endItem;
    private String urlPattern;

    public void calculateTotalPage() {
        this.totalPage = (totalRecord % pageSize == 0)
                ? (totalRecord / pageSize)
                : (totalRecord / pageSize) + 1;
    }

    public void setCurrentPage(int page) {
        this.page = (page <= 0) ? 1 : Math.min(page, totalPage);
    }

    public String createUrlPattern(String baseUrl) {
        return baseUrl + "?page=";
    }
}
