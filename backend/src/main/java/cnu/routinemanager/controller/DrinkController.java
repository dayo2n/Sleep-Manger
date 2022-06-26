package cnu.routinemanager.controller;

import java.time.LocalDate;
import java.util.List;
import javax.validation.Valid;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import cnu.routinemanager.dto.request.DrinkNotificationTimeRequest;
import cnu.routinemanager.dto.request.DrinkRecordRequest;
import cnu.routinemanager.dto.response.DrinkNotificationTimeResponse;
import cnu.routinemanager.dto.response.DrinkRecordResponse;
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
    // GET /drinks/times
    @GetMapping(value = "times")
    public ResponseEntity<DrinkNotificationTimeResponse> findDrinkNotificationTime(@RequestParam(value = "id") Long id) {
        return ResponseEntity.ok().body(drinkNotificationTimeService.findDrinkNotificationTime(id));
    }
    // POST /drinks/times
    @PostMapping(value = "times")
    public ResponseEntity<Void> createDrinkNotificationTimes(@Valid @RequestBody DrinkNotificationTimeRequest drinkNotificationTimeRequest) {
        drinkNotificationTimeService.createDrinkNotificationTimes(drinkNotificationTimeRequest);
        return ResponseEntity.status(HttpStatus.CREATED).build();
    }
    // PUT /drinks/times
    @PutMapping(value = "times")
    public ResponseEntity<Void> setDrinkNotificationTime(@Valid @RequestBody DrinkNotificationTimeRequest drinkNotificationTimeRequest) {
        drinkNotificationTimeService.setDrinkNotificationTime(drinkNotificationTimeRequest);
        return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
    }
    // PUT drinks/day
    @PutMapping(value = "day")
    public ResponseEntity<Void> createOrUpdateDrinkRecord(@Valid @RequestBody DrinkRecordRequest drinkRecordRequest) {
        boolean isCreated = drinkService.createOrUpdateDrinkRecord(drinkRecordRequest);
        if (isCreated) {
            return ResponseEntity.status(HttpStatus.CREATED).build();
        }
        return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
    }
    // PATCH /drinks/day
    @PatchMapping(value = "day")
    public ResponseEntity<Void> modifyDrinkRecord(@Valid @RequestBody DrinkRecordRequest drinkRecordRequest) {
        drinkService.modifyDrinkRecord(drinkRecordRequest);
        return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
    }
    // GET /drinks/day
    @GetMapping(value = "day")
    public ResponseEntity<DrinkRecordResponse> findDrinkRecord(@RequestParam(value = "id") Long id, @RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate date) {
        DrinkRecordResponse drinkRecord = drinkService.findDrinkRecord(id, date);
        return ResponseEntity.ok().body(drinkRecord);
    }
    // GET /drinks/period
    @GetMapping(value = "period")
    public ResponseEntity<List<DrinkRecordResponse>> findDrinkRecords(@RequestParam(value = "id") Long id, @RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate date, int offset) {
        List<DrinkRecordResponse> drinkRecord = drinkService.findDrinkRecord(id, date, offset);
        return ResponseEntity.ok().body(drinkRecord);
    }
}
