package entity;

import java.sql.Timestamp;
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
public class Feedback {

    private int id;
    private String name;
    private String phone;
    private String message;
    private Timestamp created_at;
    private int user_id;
    private boolean is_resolved; // Thuộc tính này cần được khai báo đúng
    private String email;

    public boolean isIs_resolved() {
        return is_resolved;
    }

    public void setIs_resolved(boolean is_resolved) {
        this.is_resolved = is_resolved;
    }
    
}
