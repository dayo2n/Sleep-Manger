package cnu.routinemanager.dto.response;

import java.time.LocalTime;
import java.util.List;
import java.util.stream.Collectors;

import com.fasterxml.jackson.annotation.JsonFormat;

import cnu.routinemanager.domain.DrinkNotificationTime;
import lombok.Getter;
import lombok.NoArgsConstructor;

// Front 로 보낼때 데이터 format
@Getter
@NoArgsConstructor
public class DrinkNotificationTimeResponse {
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "HH:mm", timezone = "Asia/Seoul")
    private List<LocalTime> drinkNotificationTimes;

    public DrinkNotificationTimeResponse(List<LocalTime> drinkNotificationTimes) {
        this.drinkNotificationTimes = drinkNotificationTimes;
    }

    public static DrinkNotificationTimeResponse from(List<DrinkNotificationTime> drinkNotificationTimes) {
        return new DrinkNotificationTimeResponse(drinkNotificationTimes.stream().map(DrinkNotificationTime::getDrinkTime).collect(Collectors.toList()));
    }
}
