package com.ssgm.application.web;

import com.github.pagehelper.Page;
import com.ssgm.application.entity.Mail;
import com.ssgm.application.entity.Partner;
import com.ssgm.application.service.PartnerService;
import com.ssgm.application.util.MailOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

/**
 * @Author By: Wu Yongzhen
 * @Description Partner控制层
 * @Data 10:35 2018/3/16
 * @Modified By:
 **/
@Controller
@RequestMapping("partner")
public class PartnerController {
    @Autowired
    private PartnerService PartnerService;

    MailOperation operation = new MailOperation();

    /**
     * @Author By:Wu Yongzhen
     * @Description 跳转至合伙人管理页面
     * @Date 11:47 2018/3/16
     */
    @RequestMapping("skipPartner")
    public String skipPartner() {
        return "partner";
    }

    /**
     * @Author By:Wu Yongzhen
     * @Description 合伙人展示数据，包括列表，分页，条件查询，时间查询
     * @Date 11:47 2018/3/16
     */

    @ResponseBody
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public Map<String, Object> findList(
            @RequestParam(value = "parameter", defaultValue = "") String parameter,
            @RequestParam(value = "pageNum", defaultValue = "1") int pageNum,
            @RequestParam(value = "pageSize", defaultValue = "10") int pageSize) {
        Page<Partner> page = PartnerService.findList(parameter, pageNum, pageSize);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("pageData", page);
        map.put("number", page.getTotal());
        return map;
    }

    /**
     * @Author By:Wu Yongzhen
     * @Description 合伙人申请存入数据库
     * @Date 11:47 2018/3/16
     */
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public Integer add(Partner parameters) throws Exception {
        if (PartnerService.insertPartner(parameters) == 1) {
            StringBuffer sb = new StringBuffer();
            String str = String.format(Mail.SUBJECT_HHR_FORMAT, parameters.getName(), parameters.getAge(), parameters.getPhone(), parameters.getNativePlace(), parameters.getMailbox(), parameters.getCompanyName(), parameters.getDuty(), parameters.getSite());
            sb.append("<!DOCTYPE>" + "<div bgcolor='#f1fcfa'   style='border:1px solid #d9f4ee; font-size:14px; line-height:22px; color:#005aa0;padding-left:1px;padding-top:5px;   padding-bottom:5px;'><span style='font-weight:bold;'>温馨提示：</span>"
                    + "<div style='width:950px;font-family:arial;'>新的合伙人申请信息，详情请登录管理平台查看：<br/><h2 style='color:green'>"
                    + str + "</h2><br/>本邮件由系统自动发出，请勿回复。<br/>感谢您的使用。<br/>北京盛世光明软件股份有限公司</div>"
                    + "</div>");
//        调用短信接口
            operation.sendMail(Mail.USER, Mail.PASSWORD, Mail.HOST, Mail.FROM, Mail.FROM_TO,
                    Mail.SUBJECT_HHR, sb.toString());
        }
        return 1;
    }

    /**
     * @Author By:Wu Yongzhen
     * @Description 添加备注
     * @Date 11:47 2018/3/16
     */
    @RequestMapping(value = "/saveRemark", method = RequestMethod.GET)
    public void saveRemark(Partner parameters) {
        PartnerService.saveRemark(parameters);
    }
}
