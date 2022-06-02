package cnu.routinemanager.dto.response;

import java.time.LocalTime;

import com.fasterxml.jackson.annotation.JsonFormat;

public class DaySleepRecordResponse {
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "HH:mm", timezone = "Asia/Seoul")
    private LocalTime bedTime;

    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "HH:mm", timezone = "Asia/Seoul")
    private LocalTime wakeUpTime;

    public DaySleepRecordResponse(LocalTime bedTime, LocalTime wakeUpTime) {
        this.bedTime = bedTime;
        this.wakeUpTime = wakeUpTime;
    }
}
