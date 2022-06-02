package cnu.routinemanager.controller;

import java.time.LocalDate;
import java.util.List;
import javax.validation.Valid;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import cnu.routinemanager.dto.request.DaySleepRecordRequest;
import cnu.routinemanager.dto.request.GoalSleepTimeRequest;
import cnu.routinemanager.dto.response.DaySleepRecordResponse;
import cnu.routinemanager.dto.response.GoalSleepResponse;
import cnu.routinemanager.service.GoalSleepService;
import cnu.routinemanager.service.SleepService;

@RestController
@RequestMapping("/sleeps")
public class SleepController {
    private final GoalSleepService goalSleepService;
    private final SleepService sleepService;

    public SleepController(GoalSleepService goalSleepService, SleepService sleepService) {
        this.goalSleepService = goalSleepService;
        this.sleepService = sleepService;
    }

    @GetMapping(value = "goals")
    public ResponseEntity<GoalSleepResponse> findGoalSleepTime(@RequestParam(value = "id") Long id) {
        GoalSleepResponse goalSleepTimeResponse = goalSleepService.findGoalSleepTime(id);
        return ResponseEntity.ok()
                             .body(goalSleepTimeResponse);
    }

    @PutMapping(value = "goals")
    public ResponseEntity<Void> setGoalSleepTime(@Valid @RequestBody GoalSleepTimeRequest goalSleepTimeRequest) {
        goalSleepService.setGoalSleepTime(goalSleepTimeRequest);
        return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
    }

    @PostMapping(value = "day")
    public ResponseEntity<Void> createDaySleepRecord(@Valid @RequestBody DaySleepRecordRequest daySleepRecordRequest) {
        sleepService.createDaySleepRecord(daySleepRecordRequest);
        return ResponseEntity.status(HttpStatus.CREATED).build();
    }

    @GetMapping(value = "day")
    public ResponseEntity<DaySleepRecordResponse> findDaySleepRecord(@RequestParam(value = "id") Long id, @RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate date) {
        DaySleepRecordResponse daySleepRecord = sleepService.findDaySleepRecord(id, date);
        return ResponseEntity.ok().body(daySleepRecord);
    }

    @GetMapping(value = "period")
    public ResponseEntity<List<DaySleepRecordResponse>> findDaySleepRecord(@RequestParam(value = "id") Long id, @RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate date, int offset) {
        List<DaySleepRecordResponse> periodSleepRecords = sleepService.findPeriodSleepRecord(id, date, offset);
        return ResponseEntity.ok().body(periodSleepRecords);
    }
}
