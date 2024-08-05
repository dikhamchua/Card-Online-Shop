    /*
     * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
     * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
     */
    package entity;

    import java.time.LocalDateTime;
    import lombok.AllArgsConstructor;
    import lombok.Builder;
    import lombok.Data;
    import lombok.Getter;
    import lombok.NoArgsConstructor;
    import lombok.Setter;
    import lombok.ToString;

    /**
     *
     * @author FPTSHOP
     */
    @ToString
    @Builder
    @Data
    @AllArgsConstructor
    @NoArgsConstructor
    @Getter
    @Setter
    public class Orders {

        private int ID;
        private int UserID;
        private double TotalMoney;
        private LocalDateTime CreatedAt;
        private LocalDateTime UpdatedAt;
        private int CreatedBy;
        private boolean IsDelete;
        private int DeletedBy;
        private LocalDateTime DeletedAt;
    }
