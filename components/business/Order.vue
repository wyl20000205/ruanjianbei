
<template>
  <div id="components_business_order">
    <div class="header">
      <div class="left">
        <p>
          <input
            type="text"
            placeholder="搜点什么吧 😅"
            v-model="search_text"
            @keyup.enter="search_trade"
          />
          <i class="yumao icon-sousuo" @click="search_trade"></i>
          <i class="yumao icon-dacha" @click="search_cancel"></i>
        </p>
      </div>
      <div class="right">
        <i  @click="export_result">导出结果</i>
        <!-- <i class="successed" @click="filter_data(1)">已完成</i> -->
        <!-- <i  @click="filter_data(200)">取消检索</i> -->
      </div>
    </div>
    <div class="content">
      <div class="title">
        <em class="title_01">编号号码</em>
        <em class="title_02">岗位名称</em>
        <em class="title_03">真实姓名</em>
        <em class="title_04">最高学历</em>
        <em class="title_05">面试时间</em>
        <em class="title_06">个人简历</em>
        <em class="title_07">面试状态</em>
        <em class="title_08">面试状态</em>
      </div>
      <div class="main">
        <div :class="'order_' + v.id" v-for="(v, i) in 10" :key="i">
          <p class="tag_01">
            <i>{{randomChoice(['20123','21232','21123','21122'])}}</i>
          </p>
          <p class="tag_02">
            <i>{{randomChoice(['大学辅导员','大学正教授','图书管理员','大学副教授'])}}</i>
          </p>
          <p class="tag_03">
            <i>{{randomChoice(['张三丰','Yumao','Huauo','Wuad2'])}}</i>
          </p>
          <p class="tag_04">
            <i>{{randomChoice(['大学本科','大学专科','大学硕士','大学博士'])}}</i>
          </p>
          <p class="tag_05">
            <i>{{randomChoice(['2025-07-02 12:12:00','2025-07-02 00:12:00','2025-07-05 12:21:00','2025-05-01 15:21:00'])}}</i>
          </p>
          <p class="tag_06">
            <i @click="look_resume">查看简历</i>
          </p>
         <p class="tag_07" @click="go_live">
            <i >进入面试</i>
          </p>
          <p class="tag_08">
            <i
              @click="look_status(v)"
              :class="'已完成'== '已完成' ? 'successed' : 'failed'"
              >已完成</i
            >
          </p>
        </div>
      </div>
    </div>
     <Transition name="show_resume" tip="estimate" mode="out-in">
      <div id="show_estimate" v-show="show_resume">
        <div class="back" @click="show_resume_fn"></div>
        <div class="content">
          <p class="title">下面是应聘者个人简历 🫡</p>
          <div class="main">
            <div class="personal_info">
              <p><img src="/images/miku.jpg" alt=""></p>
              <p>姓名: Miku</p>
              <p>性别: 男</p>
              <p>年龄: 25</p>
              <p>学历: 大学本科</p>
              <p>专业: 计算机科学与技术</p>
              <p>毕业院校: 广东科技大学</p>
            </div>
            <div class="system_info">
              <p>工作经历:</p>
              <p>2019-2021: 广东科技大学计算机系助教</p>
              <p>2021-2022: 广东科技大学计算机系讲师</p>
              <p>2022-2023: 广东科技大学计算机系教授</p>
            </div>
          </div>
          <span class="cancel" @click="show_resume_fn"
            ><i class="yumao icon-dacha"></i
          ></span>
        </div>
      </div>
    </Transition>
  </div>
</template>

<script setup>
import { indexStore } from "~/store";
import { storeToRefs } from "pinia";
import _ from "lodash";
import business_api from "~/axios/business";
import { businessStore } from "~/store/business";
import writeFileXlsx from "write-excel-file";
const randomInt = (min, max) => Math.floor(Math.random() * (max - min)) + min;
const randomChoice = (arr) => arr[randomInt(0, arr.length)];

let export_result = async ()=>{
   let header_row = [
    { value: "编号号码" },
    { value: "岗位名称" },
    { value: "真实姓名" },
    { value: "毕业学校" },
    { value: "学历学位" },
    { value: "系统成绩" },
  ];
  let write_data = [header_row];
  
  for (let i = 1; i < 15; i++) {
    let row = [];
    row.push({ value: randomInt(0, 100000) });
    row.push({ value: randomChoice(['大学辅导员','大学正教授','图书管理员','大学副教授']) });
    row.push({ value: randomChoice(['Miku','Yumao','Huauo','Wuad2']) });
    row.push({ value: randomChoice(['广东科技大学']) });
    row.push({ value: randomChoice(['大学本科','大学专科','大学硕士','大学博士']) });
    row.push({ value: randomInt(60, 81)});
    write_data.push(row);
  }
  await writeFileXlsx(write_data, {
    fileName: "所有面试结果.xlsx",
  }); 
}
let router = useRouter();
let go_live = ()=>{
  router.push({path:'/live'});
}
let show_resume = ref(false);
let show_resume_fn = ()=>{
 show_resume.value = !show_resume.value;
}

let { show_select_status, trade_status, selected_trade, order_data } =
  storeToRefs(businessStore());

order_data = ref(await business_api.get_order());
let search_text = ref("");

if (order_data.value.length) {
  order_data.value.forEach((v) => {
    v.status_text = v.status == "-1" ? "未完成" : "已完成";
    if (v.estimate == 0) v.estimate_text = "未评价";
    else if (v.estimate == -1) v.estimate_text = "用户删除";
    else if (v.estimate == -2) v.estimate_text = "管理员删除";
    else if (v.estimate == 1) v.estimate_text = v.estimate_content;
  });
}

let look_status = (v) => {
  show_select_status.value = true;
  trade_status.value = v.status;
  selected_trade.value = v;
};
let search_trade = async () => {
  if ((await business_api.search_trade(search_text.value)).length)
    (order_data.value = await business_api.search_trade(search_text.value)),
      format_data();
  else alert("无数据 😀");
};
let search_cancel = async () => {
  order_data.value = await business_api.get_order();
  search_text.value = "";
  format_data();
};

let filter_data = async (index) => {
  order_data.value = await business_api.get_order(index)
  format_data()
};

let format_data = () => {
  if (order_data.value.length) {
    order_data.value.forEach((v) => {
      v.status_text = v.status == "-1" ? "未完成" : "已完成";
      if (v.estimate == 0) v.estimate_text = "未评价";
      else if (v.estimate == -1) v.estimate_text = "用户删除";
      else if (v.estimate == -2) v.estimate_text = "管理员删除";
      else if (v.estimate == 1) v.estimate_text = v.estimate_content;
    });
  }
};
let look_resume = ()=>{
  show_resume.value = !show_resume.value;
}
</script>

<style lang="less">
  .show_resume-enter-active,
  .show_resume-leave-active {
    transition: all 0.3s;
  }
  .show_resume-enter-from,
  .show_resume-leave-to {
    opacity: 0;
    transform: blur(1px);
    // filter: blur(1px);
  }

#components_business_order {
background: white;
    #show_estimate {
    width: 100%;
    height: 100%;
    position: absolute;
    top: 0;
    left: 0;
    z-index: 4;
    .back {
      position: absolute;
      top: 0;
      width: 100%;
      height: 100%;
      background: rgba(181, 174, 174, 0.94);
    }
    .content {
      position: absolute;
      display: flex;
      flex-direction: column;
      align-items: center;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      width: 500px;
      height: 600px;
      background: white;
      border-radius: 1px;
      p.title {
        margin-top: 30px;
        margin-bottom: 55px;
        font-size: 20px;
        text-align: center;
      }
      .main {
        width: 85%;
        overflow: auto;
        margin-bottom: 30px;
        max-height: 500px;
        >div{
          margin-bottom: 25px;
        }

        .personal_info{
          margin-bottom: 40px;
         p{
          width: 100%;
          margin: 0 auto;
          margin-bottom: 10px;
        }
        >p:nth-of-type(1){
          margin-bottom: 20px;
          img{
          width: 100px;
          border-radius: 2px;
        }
       
        }
      }
      .system_info{
        p{
          width: 100%;
          margin: 0 auto;
          margin-bottom: 10px;
        }
        >p:nth-of-type(1){
          margin-bottom: 8px;
        }
        
      }
      }
      .cancel {
        position: absolute;
        top: -8px;
        right: -8px;
        width: 25px;
        height: 25px;
        transition: all 0.4s;
        cursor: pointer;
        background: white;
        box-shadow: 0 0 1px 1px rgba(53, 52, 52, 0.1);
        border-radius: 1px;
        display: flex;
        justify-content: center;
        align-items: center;
        &:hover {
          transform: translate(-5px, 5px);
        }
        i {
          font-size: 19px;
          color: rgb(55, 181, 193);
        }
      }
    }
  }
  .header {
    display: flex;
    justify-content: center;
    align-items: center;
    margin: 10px auto 15px auto;
    height: 60px;
    > div {
      width: 45%;
      height: inherit;
      margin-top: 15px;
    }
    .left {
      display: flex;
      align-items: center;
      > p {
        margin-left: 7px;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 50%;
        border-radius: 2px;
        width: 250px;
        border: 1px solid rgb(241, 236, 236);
        transition: all 0.5s;

        &:hover {
          border: 1px solid rgb(136, 185, 241);
        }
        input {
          width: 70%;
          font-size: 18px;
          color: rgb(61, 58, 58);
        }
        input::-webkit-input-placeholder {
          font-size: 15px;
        }
        i {
          color: rgb(187, 181, 181);
          cursor: pointer;
          margin-left: 6px;
        }
        .icon-sousuo {
          margin-right: 5px;
          font-size: 16px !important;
        }
        .icon-dacha {
          font-size: 16px !important;
        }
      }
    }
    .right {
      display: flex;
      justify-content: flex-end;
      align-items: center;
      i {
        color: rgb(48, 46, 46);
        cursor: pointer;
        transition: all 0.5s;
        margin: 0 10px;
      }
      .successed {
        color: green;
      }
      .failed {
        color: red;
      }
    }
  }
  >.content {
    width: 89%;
    height: 425px;
    margin: 0 auto;
    color: rgb(44, 43, 43);
    font-size: 15.5px;
    .title {
      display: flex;
      align-items: center;
      width: 100%;
      height: 40px;
      border-bottom: 1px solid rgba(242, 236, 236, 0.9);
      .title_01 {
        width: 10%;
      }
      .title_02 {
        width: 12%;
      }
      .title_03 {
        width: 10%;
      }
      .title_04 {
        width: 10%;
      }
      .title_05 {
        width: 15%;
      }
      .title_06 {
        width: 8%;
      }
      .title_07 {
        width: 8%;
      }
      em {
        margin-right: 20px;
        line-height: 40px;
        height: 100%;
      }
    }
    .main {
      overflow: auto;
      height: 90%;
      width: 100%;
      margin: 0 auto;
      > div {
        height: 35px;
        display: flex;
        margin-bottom: 5px;
        border-bottom: 1px solid rgb(242, 239, 239);
        transition: all 0.5s;
        background: white;

        &:hover {
          background: rgb(250, 250, 250);
        }
        .tag_01 {
          width: 10%;
        }
        .tag_02 {
          width: 12%;
        }
        .tag_03 {
          width: 10%;
        }
        .tag_04 {
          width: 10%;
        }
        .tag_05 {
          width: 15%;
        }
        .tag_06 {
          width: 8%;
          cursor: pointer;
        }
        .tag_07 {
          width: 8%;
          cursor: pointer;
        }

        > p {
          margin-right: 20px;
          display: flex;
          align-items: center;
          i {
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
          }
        }
        > p:last-child {
          i {
            transition: all 0.2s;
            margin-right: 20px;
            cursor: pointer;
            &:hover {
              color: rgb(33, 121, 156);
            }
          }
        }
        .successed {
          color: green;
        }
        .failed {
          color: red;
        }
      }
    }
  }
}
</style>