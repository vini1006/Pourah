package com.viniv.pourah.model.news.repository;

import java.util.List;

import com.viniv.pourah.model.domain.News;

public interface NewsDAO {
	public void insert(News news);
	
	public List selectAll();
	
	public void updateCheck(int news_id); 

}
