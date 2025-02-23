package com.dao;

import com.entity.ShangdianEntity;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import java.util.List;
import java.util.Map;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;

import org.apache.ibatis.annotations.Param;
import com.entity.view.ShangdianView;

/**
 * 酒店商店表 Dao 接口
 *
 * @since 2021-03-09
 */
public interface ShangdianDao extends BaseMapper<ShangdianEntity> {

   List<ShangdianView> selectListView(Pagination page,@Param("params")Map<String,Object> params);

}
