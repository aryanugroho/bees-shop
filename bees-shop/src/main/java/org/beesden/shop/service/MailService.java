package org.beesden.shop.service;

import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.stereotype.Service;

@Service("mailService")
public class MailService {

	private MailSender mailSender;

	public void sendMail(String subject, String msg) {

		SimpleMailMessage message = new SimpleMailMessage();

		message.setFrom("info@outstore.com");
		message.setTo("toby.marson@gmail.com");
		message.setSubject(subject);
		message.setText(msg);
		mailSender.send(message);
	}

	public void setMailSender(MailSender mailSender) {
		this.mailSender = mailSender;
	}
}