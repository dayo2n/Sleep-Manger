package cnu.routinemanager.dto.response;

import java.time.LocalDate;

import com.fasterxml.jackson.annotation.JsonFormat;

// Front 로 보낼때 데이터 format
public class DrinkRecordResponse {
    @JsonFormat(pattern = "yyyy-MM-dd")
    private LocalDate date;

    @JsonFormat(shape = JsonFormat.Shape.NUMBER_INT)
    private int amount;

    public DrinkRecordResponse(LocalDate date, int amount) {
        this.date = date;
        this.amount = amount;
    }
}
