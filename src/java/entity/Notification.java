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

public class Notification {

    private int notificationId;
    private int UserID;
    private String message;
    private boolean read;
    private Timestamp createdAt;
    private boolean forAllUsers;
}
