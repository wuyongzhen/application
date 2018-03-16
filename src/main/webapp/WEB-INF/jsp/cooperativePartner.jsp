<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set value="${pageContext.request.contextPath }" var="cxt"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>合作商信息管理</title>
    <!-- import Vue before Element -->
    <script src="https://cdn.bootcss.com/vue/2.5.13/vue.min.js"></script>
    <!-- 引入组件库 -->
    <script src="https://cdn.bootcss.com/element-ui/2.2.1/index.js"></script>
    <!-- import CSS -->
    <link href="https://cdn.bootcss.com/element-ui/2.2.1/theme-chalk/index.css" rel="stylesheet">
    <script src="https://cdn.bootcss.com/axios/0.18.0/axios.min.js"></script>
    <script src="https://cdn.bootcss.com/moment.js/2.21.0/moment.min.js"></script>
    <script src="https://cdn.bootcss.com/vue-resource/1.5.0/vue-resource.min.js"></script>
    <script src="${cxt}/laydate/laydate.js"></script> <!-- 时间控件 -->
    <style>
        .demo-table-expand {
            font-size: 0;
        }

        .demo-table-expand label {
            width: 120px;
            color: #99a9bf;
        }

        .demo-table-expand .el-form-item {
            margin-right: 0;
            margin-bottom: 0;
            width: 50%;
        }
    </style>
</head>
<body>
<div id="app">
    <el-row>
        <el-col :span="6">
            <div class="grid-content bg-purple-dark">
                <button></button>
            </div>
        </el-col>
        <el-col :span="18">
            <div class="grid-content bg-purple-dark">
                <template>
                    <!--查询头-->
                    <el-row>
                        <el-col :span="11">
                            <div class="grid-content bg-purple-dark">
                                <el-input placeholder="请输入手机号或负责人搜索" v-model="criteria" style="padding-bottom:10px;">
                                    <el-button slot="append" v-on:click="search">搜索</el-button>
                                </el-input>
                            </div>
                        </el-col>
                        <el-col :span="2">
                            <div class="grid-content bg-purple-dark">&nbsp;</div>
                        </el-col>
                        <el-col :span="11">
                            <div class="grid-content bg-purple-dark">
                                <el-input id="test1" placeholder="根据时间搜索" v-model="date"
                                          style="padding-bottom:10px;">
                                    <el-button slot="append" v-on:click="search_time">搜索</el-button>
                                </el-input>
                            </div>
                        </el-col>
                    </el-row>
                    <!--table-->
                    <el-row>
                        <el-col :span="24">
                            <div class="grid-content bg-purple-dark">
                                <el-table
                                        :data="cooperation"
                                        border
                                        style="width: 100%">
                                    <el-table-column type="expand">
                                        <template slot-scope="props">
                                            <el-form label-position="left" inline class="demo-table-expand">
                                                <el-form-item label="成立时间">
                                                    <span>{{ props.row.establishedTime }}</span>
                                                </el-form-item>
                                                <el-form-item label="法人代表">
                                                    <span>{{ props.row.legalPersonality }}</span>
                                                </el-form-item>
                                                <el-form-item label="职务">
                                                    <span>{{ props.row.duty }}</span>
                                                </el-form-item>
                                                <el-form-item label="手机号">
                                                    <span>{{ props.row.mobile }}</span>
                                                </el-form-item>
                                                <el-form-item label="电子邮箱">
                                                    <span>{{ props.row.email }}</span>
                                                </el-form-item>
                                                <el-form-item label="主营业务">
                                                    <span>{{ props.row.business }}</span>
                                                </el-form-item>
                                                <el-form-item label="客户主体">
                                                    <span>{{ props.row.clientSubject }}</span>
                                                </el-form-item>
                                                <el-form-item label="公司核心优势">
                                                    <span>{{ props.row.advantage }}</span>
                                                </el-form-item>
                                                <el-form-item label="申请北京考察">
                                                    <span>{{ props.row.inspect }}</span>
                                                </el-form-item>
                                                <el-form-item label="意向产品项目">
                                                    <span>{{ props.row.intention }}</span>
                                                </el-form-item>
                                                <el-form-item label="公司地址">
                                                    <span>{{ props.row.companyAddress }}</span>
                                                </el-form-item>
                                                <el-form-item label="公司人数">
                                                    <span>{{ props.row.companyScale }}</span>
                                                </el-form-item>
                                                <el-form-item label="公司性质">
                                                    <span>{{ props.row.nature }}</span>
                                                </el-form-item>
                                            </el-form>
                                        </template>
                                    </el-table-column>
                                    <el-table-column
                                            type="index"
                                            :index="indexMethod">
                                    </el-table-column>
                                    <el-table-column
                                            label="公司全称"
                                            prop="companyName">
                                    </el-table-column>
                                    <el-table-column
                                            label="注册资本"
                                            prop="registeredCapital">
                                    </el-table-column>
                                    <el-table-column
                                            label="公司年流水"
                                            prop="companyWater">
                                    </el-table-column>
                                    <el-table-column
                                            label="负责人"
                                            prop="principal">
                                    </el-table-column>
                                    <el-table-column
                                            width="180"
                                            label="申请时间"
                                            prop="creationTime">
                                    </el-table-column>
                                    <el-table-column label="操作">
                                        <template slot-scope="scope">
                                            <el-button
                                                    size="mini"
                                                    type="success"
                                                    @click="remark(scope.row.id,scope.row.remark)">备注
                                            </el-button>
                                        </template>
                                    </el-table-column>
                                </el-table>
                            </div>
                        </el-col>
                    </el-row>
                    <!--分页-->
                    <el-row>
                        <el-col :span="24">
                            <div class="grid-content bg-purple-dark" style="margin-top: 30px;">
                                <div align="center">
                                    <el-pagination
                                            @size-change="handleSizeChange"
                                            @current-change="handleCurrentChange"
                                            :current-page="currentPage"
                                            :page-sizes="[10, 20, 30, 40]"
                                            :page-size="pagesize"
                                            layout="total, sizes, prev, pager, next, jumper"
                                            :total="totalCount">
                                    </el-pagination>
                                </div>
                            </div>
                        </el-col>
                    </el-row>
                </template>
            </div>
        </el-col>
    </el-row>
</div>
</body>
<script>
    new Vue({
        el: '#app',
        data: {
            cooperation: [],
            //多选数组
            multipleSelection: [],
            //请求的URL
            url: '${cxt}/cooperation/list',
            //搜索条件
            criteria: '',
            //根据时间搜索条件
            date: '',
            //下拉菜单选项
            select: '',
            //默认每页数据量
            pagesize: 10,
            //默认高亮行数据id
            highlightId: -1,
            //当前页码
            currentPage: 1,
            //查询的页码
            start: 1,
            //默认数据总数
            totalCount: 100,
        },
        methods: {
            //从服务器读取数据
            loadData: function (criteria, pageNum, pageSize) {
                var _this = this;
                axios.get(this.url, {
                    params: {
                        parameter: criteria,
                        pageNum: pageNum,
                        pageSize: pageSize
                    }
                }).then(function (res) {
                    if (!res.data) {
                        alert('数据加载失败，请刷新页面重试！');
                        return;
                    }
                    var data = res.data;
                    var project = ['网路宝（盛世云+无线WI-FI监管）项目', '网路神警上网行为审计项目（大型场所）', '特征码采集（卡扣）项目', '食品安全快检技术项目']
                    for (var i = 0; i < res.data.pagestudentdata.length; i++) {
                        data.pagestudentdata[i].intention = project[data.pagestudentdata[i].intention - 1];
                        data.pagestudentdata[i].inspect = data.pagestudentdata[i].inspect == 0 ? '否' : '是';
                        data.pagestudentdata[i].establishedTime = moment(data.pagestudentdata[i].establishedTime).format('YYYY-MM-DD');//moment.js 格式化时间戳
                        data.pagestudentdata[i].creationTime = moment(data.pagestudentdata[i].creationTime).format('YYYY-MM-DD HH:mm:ss');//moment.js 格式化时间戳
                    }
                    _this.cooperation = data.pagestudentdata;
                    _this.totalCount = data.number;
                }).catch(function (error) {
                    alert('数据加载失败，请刷新页面重试！');
                });
            },
            //每页显示数据量变更
            handleSizeChange: function (val) {
                this.pagesize = val;
                this.loadData(this.criteria, this.currentPage, this.pagesize);
            },
            //页码变更
            handleCurrentChange: function (val) {
                this.currentPage = val;
                this.loadData(this.criteria, this.currentPage, this.pagesize);
            },
            //搜索
            search: function () {
                this.loadData(this.criteria, this.currentPage, this.pagesize);
                this.criteria = ''
            },
            //根据时间搜索
            search_time: function () {
                console.log(this.date + "11111")
                this.loadData(this.date, this.currentPage, this.pagesize);
                this.date = ''
            },
            //序号
            indexMethod(index) {
                return index + 1;
            },
            //点击备注弹框
            remark(row, index) {
                this.loadData(this.criteria, this.currentPage, this.pagesize);
                this.$prompt('请输入备注信息', '提示', {
                    inputValue: index,
                    confirmButtonText: '确定',
                    cancelButtonText: '取消'
                }).then(({value}) => {
                    console.log(row+"---"+index+"----"+value)
                    this.save_remark(row,value);

                    this.$message({
                        type: 'success',
                        message: '备注信息保存成功！'
                    });
                }).catch(() => {
                    this.$message({
                        type: 'info',
                        message: '取消输入'
                    });
                });

            },
            save_remark(row,value) {
                axios.get('${cxt}/cooperation/saveRemark', {
                    params: {
                        id:row,
                        remark:value
                    }
                });
            }
        },
        //载入数据
        created: function () {
            this.loadData(this.criteria, this.currentPage, this.pagesize);
        },
        mounted: function () {
            // laydate时间控件
            var _this = this;
            laydate.render({
                elem: '#test1',
                theme: 'grid',
                done: function (value) {
                    console.log(value); //得到日期生成的值，如：2017-08-18
                    _this.date = value;
                }
            })
        }
    });
</script>
<script>

</script>
</html>