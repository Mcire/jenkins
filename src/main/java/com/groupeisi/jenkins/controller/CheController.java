package com.groupeisi.jenkins.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api")
public class CheController {
    @GetMapping("/jenkins")
    public String jenkins(){
        return "Welcome jenkins website";
    }
}
