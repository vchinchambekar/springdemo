package com.arska;

import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestMapping;

@RestController
public class SpringdemoController {
  @RequestMapping("/")
  public String index() {
    return "Hello! Vijay C";
  }
}
