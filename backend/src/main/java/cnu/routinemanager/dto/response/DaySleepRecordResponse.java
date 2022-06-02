package cnu.routinemanager.dto.response;

import java.time.LocalDate;
import java.time.LocalTime;

import com.fasterxml.jackson.annotation.JsonFormat;

public class DaySleepRecordResponse {
    @JsonFormat(pattern = "yyyy-MM-dd")
    private LocalDate date;

    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "HH:mm", timezone = "Asia/Seoul")
    private LocalTime bedTime;

    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "HH:mm", timezone = "Asia/Seoul")
    private LocalTime wakeUpTime;

    public DaySleepRecordResponse(LocalDate date, LocalTime bedTime, LocalTime wakeUpTime) {
        this.date = date;
        this.bedTime = bedTime;
        this.wakeUpTime = wakeUpTime;
    }
}
