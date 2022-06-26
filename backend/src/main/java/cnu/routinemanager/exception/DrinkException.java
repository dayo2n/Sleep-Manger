package cnu.routinemanager.exception;

import org.springframework.http.HttpStatus;

// 수분 섭취 관련  Exception Handler
public class DrinkException extends SleepManagerException {
    public DrinkException(String message, HttpStatus httpStatus) {
        super(message, httpStatus);
    }
}
