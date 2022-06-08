package cnu.routinemanager.dto.response;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.time.LocalDate;
import java.time.LocalTime;

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
