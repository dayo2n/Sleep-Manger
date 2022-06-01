package cnu.routinemanager.dto.response;

import java.time.LocalTime;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class GoalSleepResponse {
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "HH:mm", timezone = "Asia/Seoul")
    private LocalTime goalWakeUpTime;

    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "HH:mm", timezone = "Asia/Seoul")
    private LocalTime goalBedTime;

    public GoalSleepResponse(LocalTime goalWakeUpTime, LocalTime goalBedTime) {
        this.goalWakeUpTime = goalWakeUpTime;
        this.goalBedTime = goalBedTime;
    }
}
