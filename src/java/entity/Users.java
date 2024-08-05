package entity;

import java.time.LocalDateTime;
import java.sql.Date;
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
public class Users {

    private int ID;
    private String UserName;
    private String Email;
    private int RoleID;
    private String PasswordHash;
    private LocalDateTime CreatedAt;
    private LocalDateTime UpdatedAt;
    private int CreatedBy;
    private boolean IsDelete;
    private int DeletedBy;
    private LocalDateTime DeletedAt;
    private String profilePicture;
    private boolean Status;
    private String Gender;
    private Date DateOfBirth;

}
