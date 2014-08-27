package com.springapp.mvc.controller;

import com.springapp.mvc.model.User;
import com.springapp.mvc.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/register")
public class RegisterController {

    @Autowired
    private UserService userService;

    @ModelAttribute("user")
    public User constructUser() {
        return new User();
    }

    @RequestMapping()
    public String showRegister() {
        return "register";
    }

    @RequestMapping(method= RequestMethod.POST)
    public String doRegister(@ModelAttribute("user") User user, BindingResult result) {
        userService.save(user);
        return "redirect:/register?success=true";
    }

}
