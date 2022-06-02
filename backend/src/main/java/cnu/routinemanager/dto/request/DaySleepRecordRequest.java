package cnu.routinemanager.dto.request;

import java.time.LocalDate;
import java.time.LocalTime;
import javax.validation.constraints.NotNull;

import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class DaySleepRecordRequest {
    @NotNull
    private Long id;

    @NotNull
    private LocalTime bedTime;

    @NotNull
    private LocalTime wakeUpTime;

    @NotNull
    private LocalDate date;
}
