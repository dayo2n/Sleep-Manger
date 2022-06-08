package cnu.routinemanager.dto.request;

import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotNull;
import java.time.LocalDate;

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
