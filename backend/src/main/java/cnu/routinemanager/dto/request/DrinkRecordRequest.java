package cnu.routinemanager.dto.request;

import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotNull;
import java.time.LocalDate;

// Front 에서 수분 섭취량 정보를 받을 때 request body Format
@Getter
@NoArgsConstructor
public class DrinkRecordRequest {
    @NotNull
    private Long id;

    @NotNull
    private int amount;

    @NotNull
    private LocalDate date;

}
