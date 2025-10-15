package com.example.app.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

@Controller
public class HelloWorldController {

    @GetMapping("/")
    public String helloWorld(Model model) {
        model.addAttribute("title", "Java PostgreSQL Skeleton - Example");
        model.addAttribute("message", "Hello World!");

        return "index";
    }
}