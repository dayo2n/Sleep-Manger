package cnu.routinemanager.exception;

import org.springframework.http.HttpStatus;

public class DrinkException extends SleepManagerException {
    public DrinkException(String message, HttpStatus httpStatus) {
        super(message, httpStatus);
    }
}
