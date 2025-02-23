package com.service;

import com.baomidou.mybatisplus.service.IService;
import com.utils.PageUtils;
import com.entity.FangjianEntity;
import java.util.Map;

/**
 * 房间表 服务类
 * @since 2021-03-09
 */
public interface FangjianService extends IService<FangjianEntity> {

     PageUtils queryPage(Map<String, Object> params);

}