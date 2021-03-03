package com.viniv.pourah.model.news.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.viniv.pourah.model.domain.News;

@Repository
public class MybatisNewsDAO implements NewsDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Override
	public void insert(News news) {
		sqlSessionTemplate.insert("News.insert", news);
	}
	
	@Override
	public List selectAll() {
		return sqlSessionTemplate.selectList("News.selectAll");
	}
	
	@Override
	public void updateCheck(int news_id) {
		sqlSessionTemplate.update("News.updateCheck", news_id);
	}

}
