<template>
  <div id="UserOrder">
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
        <i class="failed" @click="select_data(1)">等待面试</i>
        <i class="successed" @click="select_data(-1)">完成面试</i>
        <i class="" @click="select_data(200)">取消过滤</i>
      </div>
    </div>
    <div class="content">
      <div class="title">
        <em class="tag_01">面试编号</em>
        <em class="tag_02">单位名称</em>
        <em class="tag_03">学院名称</em>
        <em class="tag_04">岗位名称</em>
        <em class="tag_05">报名时间</em>
        <em class="tag_06">面试时间</em>
        <em class="tag_07">开启面试</em>
        <em class="tag_08">面试状态</em>
      </div>
      <div class="main">
        <div :class="'order_' + v.id" v-for="(v, i) in interview_data" :key="i">
          <p class="tag_01">
            <i>{{ v.id }}</i>
          </p>
          <p class="tag_02">
            <i>{{v.school}}</i>
          </p>
          <p class="tag_03">
            <i>计算机学院</i>
          </p>
          <p class="tag_04">
            <i>{{v.name}}</i>
          </p>
          <p class="tag_05">
             <i>{{ v.time }} </i>
          </p>
          <p class="tag_06">
             <i>{{ v.start_time}}</i>
          </p>
           <p class="tag_07" @click="go_live" style="cursor: pointer;">
                     <i>进入面试</i>
          </p>
           <p class="tag_08" @click="show_estimate(v)">
                <i :class="v.status==1?'successed':'failed'">{{ v.status_text }}</i>
          </p>
        </div>
      </div>
    </div>
  </div>
</template>


<script setup>
import { indexStore } from "~/store";
import { userStore } from "~/store/user";
import { adminStore } from "~/store/admin";
import { storeToRefs } from "pinia";
import _ from "lodash";
import user_api from "~/axios/user";
const randomInt = (min, max) => Math.floor(Math.random() * (max - min)) + min;
const randomChoice = (arr) => arr[randomInt(0, arr.length)];
let { debounce } = _;

let { init_data } = storeToRefs(indexStore());
let { update_data, login_out, show_estimate } = userStore();
let { user_data, user_token } = storeToRefs(userStore());
let { admin_data, admin_token } = storeToRefs(adminStore());
let data = ref(await user_api.get_order());
let search_text = ref("");
let router = useRouter();
let go_live = ()=>{
  router.push({path:'/live'});
}
let interview_data = [{id:10232,school:'广东科技大学',college:'计算机学院',name:'本科辅导员',time:'2025-12-21 12:21:12',start_time:'2025-07-20 14:00:00',status:0,status_text:'未完成'},
  {id:10232,school:'河北科技大学',name:'本科辅导员',time:'2025-07-21 01:00:12',start_time:'2025-08-00 13:00:00',status:1,status_text:'已完成(72分)'},
  {id:10232,school:'天津科技大学',name:'大学小讲师',time:'2025-07-23 12:00:12',start_time:'2025-11-21 22:00:00',status:1,status_text:'已完成(62分)'},
  {id:10232,school:'广东医科大学',name:'本科辅导员',time:'2025-02-12 13:21:22',start_time:'2025-10-21 12:00:00',status:1,status_text:'已完成(52分)'},
  {id:10232,school:'北京工业大学',name:'本科辅导员',time:'2025-01-22 02:21:12',start_time:'2025-12-21 03:00:00',status:1,status_text:'已完成(77分)'},
  {id:10232,school:'南方科技大学',name:'本科辅导员',time:'2025-09-09 11:01:11',start_time:'2025-12-21 22:00:00',status:1,status_text:'已完成(81分)'},
  {id:10232,school:'上海科技大学',name:'本科辅导员',time:'2025-01-10 10-:21:00',start_time:'2025-12-21 22:00:00',status:1,status_text:'已完成(91分)'},
  {id:10232,school:'香港科技大学',name:'本科辅导员',time:'2025-01-01 01:21:32',start_time:'2025-12-21 22:00:00',status:1,status_text:'已完成(61分)'},
  {id:10232,school:'台湾科技大学',name:'本科辅导员',time:'2025-12-21 11:00:52',start_time:'2025-12-21 22:00:00',status:1,status_text:'已完成(32分)'},
  {id:10232,school:'东京科技大学',name:'本科辅导员',time:'2025-01-11 11:11:12',start_time:'2025-12-21 22:00:00',status:1,status_text:'已完成(82分)'},
]

let search_trade = async () => {
  let search_data = await user_api.search_trade(search_text.value);
  if (search_data.length) {
    data.value = search_data;
  } else alert("无数据 😀");
};
let search_cancel = async () => {
  let search_data = await user_api.search_trade("");
  data.value = search_data;
  search_text.value = "";
};

let select_data = async (index) => {
  data.value = await user_api.get_order(index);
};



</script>

<style lang="less">
#UserOrder {  
  background: white;
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
        border: 1px solid rgb(238, 232, 232);
        transition: all 0.5s;
        &:hover {
          border: 1px solid rgb(103, 164, 239);
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
          color: gray;
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
        cursor: pointer;
        transition: all 0.5s;
        margin: 0 10px;
      }
    }
  }
  .content {
    width: 89%;
    height: 420px;
    margin: 0 auto;
    color: rgb(44, 43, 43);
    font-size: 15.5px;
    .title {
      display: flex;
      align-items: center;
      width: 100%;
      height: 40px;
      border-bottom: 1px solid rgba(242, 236, 236, 0.9);

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
        > p:nth-last-of-type(1) {
          i {
            transition: all 0.2s;
            margin-right: 20px;
            cursor: pointer;
            &:hover {
              color: rgb(33, 121, 156);
            }
          }
        }
      }
    }
    .tag_01 {
      width: 8%;
    }
    .tag_02 {
      width: 10%;
    }
    .tag_03 {
      width: 10%;
    }
    .tag_04 {
      width: 10%;
    }
    .tag_05 {
      width: 14%;
    }
    .tag_06 {
      width: 14%;
    }
    .tag_07 {
      width: 8%;
    }
    .tag_08 {
      width: 10%;
    }
  
  }
  .waited {
    color: rgb(122, 175, 244);
  }
  .successed {
    color: green;
  }
  .failed {
    color: red;
  }
}
</style>