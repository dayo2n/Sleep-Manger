package cnu.routinemanager.controller;

import javax.validation.Valid;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import cnu.routinemanager.dto.request.DrinkNotificationTimeRequest;
import cnu.routinemanager.dto.response.DrinkNotificationTimeResponse;
import cnu.routinemanager.service.DrinkNotificationTimeService;
import cnu.routinemanager.service.DrinkService;

@RestController
@RequestMapping("/drinks")
public class DrinkController {

    private final DrinkService drinkService;
    private final DrinkNotificationTimeService drinkNotificationTimeService;

    public DrinkController(DrinkService drinkService, DrinkNotificationTimeService drinkNotificationTimeService) {
        this.drinkService = drinkService;
        this.drinkNotificationTimeService = drinkNotificationTimeService;
    }

    @GetMapping(value = "times")
    public ResponseEntity<DrinkNotificationTimeResponse> findDrinkNotificationTime(@RequestParam(value = "id") Long id) {
        return ResponseEntity.ok().body(drinkNotificationTimeService.findDrinkNotificationTime(id));
    }

    @PostMapping(value = "times")
    public ResponseEntity<Void> createDrinkNotificationTimes(@Valid @RequestBody DrinkNotificationTimeRequest drinkNotificationTimeRequest) {
        drinkNotificationTimeService.createDrinkNotificationTimes(drinkNotificationTimeRequest);
        return ResponseEntity.status(HttpStatus.CREATED).build();
    }

    @PutMapping(value = "times")
    public ResponseEntity<Void> setDrinkNotificationTime(@Valid @RequestBody DrinkNotificationTimeRequest drinkNotificationTimeRequest) {
        drinkNotificationTimeService.setDrinkNotificationTime(drinkNotificationTimeRequest);
        return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
    }

    //    @PostMapping(value ="day")
    //    public ResponseEntity<Void> createDrinkRecord(@Valid @RequestBody DrinkRecordRequest drinkRecordRequest){
    //        drinkService.createDrinkRecord(drinkRecordRequest);
    //        return ResponseEntity.status(HttpStatus.CREATED).build();
    //    }
    //
    //    @GetMapping(value = "day")
    //    public ResponseEntity<DrinkRecordResponse> findDrinkRecord(@RequestParam(value = "id") Long id, @RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate date) {
    //        DrinkRecordResponse drinkRecord = drinkService.findDrinkRecord(id, date);
    //        return ResponseEntity.ok().body(drinkRecord);
    //    }
    //
    //    @GetMapping(value = "period")
    //    public ResponseEntity<List<DrinkRecordResponse>> findDrinkRecord(@RequestParam(value = "id") Long id, @RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate date, int offset) {
    //        List<DrinkRecordResponse> drinkRecord = drinkService.findDrinkRecord(id, date, offset);
    //        return ResponseEntity.ok().body(drinkRecord);
    //    }
}
