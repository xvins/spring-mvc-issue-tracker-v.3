package com.springapp.mvc.controller;

import com.springapp.mvc.model.Comment;
import com.springapp.mvc.repository.CommentRepository;
import com.springapp.mvc.repository.IssueRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
public class CommentController {

    @Autowired
    private IssueRepository issueRepository;

    @Autowired
    private CommentRepository commentRepository;

    @RequestMapping(value = "/comment{id}", method = RequestMethod.GET)
    public String listComments(ModelMap model, @PathVariable long id) {
        model.addAttribute("issue", issueRepository.findOne(id));
        model.addAttribute("comment", new Comment());
        List<String> statusList = new ArrayList<String>();
        statusList.add("Resolved");
        statusList.add("Closed");
        model.addAttribute("statusList", statusList);
        model.addAttribute("comments", commentRepository.findAll());
        return "comment";
    }

    @RequestMapping(value="/comment{id}", method = RequestMethod.POST)
    public String addComment(@Valid @ModelAttribute("comment") Comment comment, BindingResult result) {
        if (result.hasErrors()) {
            return "comment";
        }
        comment.setDate(new Date());
        commentRepository.save(comment);
        return "redirect:/comment{id}";
    }

}
