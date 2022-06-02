package cnu.routinemanager.dto.response;

import java.time.LocalTime;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class GoalSleepResponse {
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "HH:mm", timezone = "Asia/Seoul")
    private LocalTime goalBedTime;

    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "HH:mm", timezone = "Asia/Seoul")
    private LocalTime goalWakeUpTime;

    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "HH:mm", timezone = "Asia/Seoul")
    private LocalTime weekendGoalBedTime;

    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "HH:mm", timezone = "Asia/Seoul")
    private LocalTime weekendGoalWakeUpTime;

    public GoalSleepResponse(LocalTime goalBedTime, LocalTime goalWakeUpTime, LocalTime weekendGoalBedTime, LocalTime weekendGoalWakeUpTime) {
        this.goalBedTime = goalBedTime;
        this.goalWakeUpTime = goalWakeUpTime;
        this.weekendGoalBedTime = weekendGoalBedTime;
        this.weekendGoalWakeUpTime = weekendGoalWakeUpTime;
    }
}
