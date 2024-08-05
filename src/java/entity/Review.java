package entity;

import java.time.LocalDateTime;
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
public class Review {

    private int id;
    private int userID;
    private int orderID;
    private int rating;
    private String title;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private Orders order;
}
