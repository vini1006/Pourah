package com.viniv.pourah.model.news.service;

import java.util.List;

import com.viniv.pourah.model.domain.News;

public interface NewsService {
	
	public void insert(News news);
	
	public List selectAll();
	
	public void updateCheck(int news_id); 

}
