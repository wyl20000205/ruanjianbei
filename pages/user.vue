<template>
  <div id="pages_user">
    <header>
      <div class="left">
        <em class="user_tag">用户:华落</em>
        <!-- <em class="user_price">余额:{{ user_data.price }}</em> -->
      </div>
      <div class="right">
        <em @click="go_home">首页</em>
        <em @click="login_out">退出</em>
      </div>
    </header>
    <section>
      <div class="content">
        <p
          v-for="(v, i) in navigation_select"
          :key="i"
          :class="i == click_index ? 'select_class' : ''"
          @click="click_index = i"
        >
          <i :class="'yumao ' + v.icon"></i><i>{{ v.text }}</i>
        </p>
      </div>
    </section>
    <main>
      <transition name="user_index" mode="out-in">
        <UserOrder v-if="click_index == 0" />
        <UserOther v-else-if="click_index == 1" />
        <UserLog v-else-if="click_index == 2" />
        <!-- <UserMoney v-else-if="click_index == 2" /> -->
        <!-- <UserLog v-else-if="click_index == 3" /> -->
      </transition>
    </main>
    <Transition name="show_detail" tip="estimate" mode="out-in">
      <div id="show_estimate" v-show="show_estimate_index">
        <div class="back" @click="show_estimate"></div>
        <div class="content">
          <p class="title">下面是你的面试表现回顾 🙌</p>
          <div class="main">
           <div class="personal_info">
            <p>🤗你个人的信息如下:</p>
            <p><em>姓名: 张三峰</em><em>性别: 男性</em><em>年龄: 32岁</em><em>学校: 广东科技大学</em><em>专业: 计算机科学与技术</em></p>
           </div>
           <div class="hr_info">
            <p>😎面试官的信息如下:</p>
            <p><em>单位名称:广东科技大学</em><em>职称: 学院副院长</em></p>
           </div>
            <div class="hr_info">
            <p>😅主要问题信息如下:</p>
            <p><em>频繁使用电子产品，缺乏眼神交流，肢体动作多，说话声音微弱</em></p>
           </div>
            <div class="hr_info">
            <p>😇面试官过程下回复:</p>
            <p><em>面试表现不错，达到合格标准</em></p>
           </div>
            <div class="system_info">
            <p>😊系统建议信息如下:</p>
            <p><em>请不要使用电子产品，多进行眼神交流，注视前方，调高声音音量</em></p>
           </div>
           <div class="graph_info">
            <div id="graph_1"></div>
            <div id="graph_2"></div>
            <div id="graph_3"></div>
           </div>
          </div>
          <span class="cancel" @click="show_estimate"
            ><i class="yumao icon-dacha"></i
          ></span>
        </div>
      </div>
    </Transition>
  </div>
</template>

<script setup>
import * as echarts from 'echarts';
import { indexStore } from "~/store";
import { userStore } from "~/store/user";
import { storeToRefs } from "pinia";
import api_user from "~/axios/user";

let { login_out, update_user, show_estimate } = userStore();
let {
  user_data,
  user_token,
  show_estimate_index,
  v_model_estimate_text,
  current_edit_food,
  estimate_status,
} = storeToRefs(userStore());
let click_index = ref(0);
let router = useRouter()

let navigation_select = ref([
  {
    icon: "icon-xuniji",
    text: "面试",
  },
  {
    icon: "icon-yundong",
    text: "信息",
  },
  // {
  //   icon: "icon-yundong",
  //   text: "账单",
  // },
  {
    icon: "icon-wenjian",
    text: "日志",
  },
]);
let go_home = () => {
  router.push({path:'/'})
  // location.href = "/";
};

let grenerte_graph = (dom,title,score)=>{
var chartDom = document.getElementById(dom);
let myChart = echarts.init(chartDom);
let option = {
  series: [
    {
      type: 'gauge',
      startAngle: 180,
      endAngle: 0,
      center: ['50%', '75%'],
      radius: '90%',
      min: 0,
      max: 1,
      splitNumber: 8,
      axisLine: {
        lineStyle: {
          width: 1,
          color: [
            [0.25, '#7CFFB2'],
            [0.5, '#FDDD60'],
            [0.75, '#58D9F9'],
            [1, '#FF6E76']
          ]
        }
      },
      pointer: {
        icon: 'path://M12.8,0.7l12,40.1H0.7L12.8,0.7z',
        length: '12%',
        width: 10,
        offsetCenter: [0, '-60%'],
        itemStyle: {
          color: 'auto'
        }
      },
      axisTick: {
        length: 10,
        lineStyle: {
          color: 'auto',
          width: 2
        }
      },
      splitLine: {
        length: 20,
        lineStyle: {
          color: 'auto',
          width: 1
        }
      },
      axisLabel: {
        color: '#464646',
        fontSize: 10,
        distance: -40,
        rotate: 'tangential',
        formatter: function (value) {
          if (value === 0.875) {
            return '优秀';
          } else if (value === 0.625) {
            return '合格';
          } else if (value === 0.375) {
            return '勉强';
          } else if (value === 0.125) {
            return '较差';
          }
          return '';
        }
      },
      title: {
        offsetCenter: [0, '-10%'],
        fontSize: 10
      },
      detail: {
        fontSize: 10,
        offsetCenter: [0, '-35%'],
        valueAnimation: true,
        formatter: function (value) {
          return Math.round(value * 100) + '';
        },
        color: 'inherit'
      },
      data: [
        {
          value: score*0.01, 
          name: title
        }
      ]
    }
  ]
};
option && myChart.setOption(option);
}
watch(
  () => show_estimate_index.value, // 监听响应式变量
  (newValue, oldValue) => {
    if(newValue){
            setTimeout(() => {

grenerte_graph('graph_1','面部表情',71)
grenerte_graph('graph_2','语音分析',73)
grenerte_graph('graph_3','加权总分',72)
            }, 100);
    }
  }
);


update_user();
useHead({
  title: "用户后台-大语言模型多模态模拟面试智能体系统",
});

</script>
<style lang="less">
#pages_user {
  position: relative;
  background: url("/images/user_bg.webp");
  background-size: 132% auto;
  background-repeat: no-repeat;
  height: 100vh;
  header {
    width: 100%;
    height: 65px;
    min-width: 1280px;
    // box-shadow: 0 1px 1px 1px rgba(169, 166, 166, 0.2);
    margin: 0 auto;
    display: flex;
    justify-content: center;
    align-items: center;
    margin-bottom: 25px;
    background: white;
    > div {
      width: 40%;
      height: 80%;
      display: flex;
      align-items: center;
    }
    .left {
      color: rgb(14, 13, 13);
      em {
        margin-right: 35px;
      }

      .add_price {
        transition: all 0.5s;
        cursor: pointer;
        &:hover {
          color: rgb(41, 173, 225);
        }
      }
    }
    .right {
      justify-content: flex-end;
      em {
        color: rgb(56, 54, 54);
        cursor: pointer;
        margin-left: 35px;
      }
    }
  }
  section {
    background: white;
    width: 90%;
    height: 60px;
    margin: 0 auto;
    margin-bottom: 25px;
    display: flex;
    justify-content: center;
    align-items: center;
    border-radius: 2px;
    .content {
      width: 89%;
      height: inherit;
      display: flex;
      align-items: center;

      p {
        cursor: pointer;
        display: flex;
        align-items: center;
        padding: 10px 10px;
        border-radius: 2px;
        margin-right: 20px;
        transition: all 0.2s;
        color: gray;
        i {
          margin: 0 2px;
        }
        &:not(.select_class):hover {
          background: rgb(249, 246, 245);
        }
      }
      .select_class {
        color: white;
        box-shadow: 0 0 1px 3px rgba(62, 182, 194, 0.1);
        background: linear-gradient(
          45deg,
          rgba(62, 182, 194, 0.8),
          rgba(62, 182, 194, 0.6)
        );
      }
      i[class^="yumao"] {
        font-size: 20px;
      }
    }
  }
  main {
    width: 90%;
    height: 550px;
    margin: 0 auto;
    i[class^="yumao"] {
      font-size: 22px;
      color: rgb(110, 101, 101);
    }
    > div {
      border-radius: 2px;
      width: 100%;
      height: inherit;
    }
  }
  #show_estimate {
    width: 100%;
    height: 100%;
    position: absolute;
    top: 0;
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
      width: 800px;
      height: 640px;
      background: white;
      border-radius: 1px;
      p.title {
        margin-top: 30px;
        margin-bottom: 30px;
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
   border-left: 2px solid skyblue;
        padding-left: 10px;
        p:nth-of-type(1){
          font-size: 20px;
          margin-bottom: 5px;
        }
  em{
    margin-right: 20px;
  }
       }
       .hr_info{
        border-left: 2px solid skyblue;
        padding-left: 10px;
         p:nth-of-type(1){
          font-size: 20px;
          margin-bottom: 5px;
        }
        
 em{
    margin-right: 20px;
  }
       }
       .system_info{
         border-left: 2px solid skyblue;
        padding-left: 10px;
            margin-bottom: 0px;
         p:nth-of-type(1){
          font-size: 20px;
          margin-bottom: 5px;
        }
        
 em{
    margin-right: 20px;
  }
       }
       .graph_info{
        display: flex;
        justify-content: space-between;
          >div{
            width: 220px;
            height: 170px;
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
  .show_detail-enter-active,
  .show_detail-leave-active {
    transition: all 0.2s;
  }
  .show_detail-enter-from,
  .show_detail-leave-to {
    opacity: 0;
    filter: blur(1px);
  }
  .user_index-enter-active,
  .user_index-leave-active {
    transition: all 0.3s;
  }
  .user_index-enter-from,
  .user_index-leave-to {
    opacity: 0;
    transform: scale(1.005);
  }
}
</style>