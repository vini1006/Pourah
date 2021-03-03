package com.viniv.pourah.model.news.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.viniv.pourah.model.domain.News;
import com.viniv.pourah.model.news.repository.NewsDAO;

@Service
public class NewsServiceImpl implements NewsService{
	
	@Autowired
	private NewsDAO newsDAO;
	
	@Override
	public void insert(News news) {
		newsDAO.insert(news);
	}
	
	@Override
	public List selectAll() {
		return newsDAO.selectAll();
	}
	
	@Override
	public void updateCheck(int news_id) {
		newsDAO.updateCheck(news_id);
	}
	
	
	
	

}
