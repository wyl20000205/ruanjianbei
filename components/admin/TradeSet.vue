<template>
  <div id="TradeSet">
    <div class="title">
      <div class="left">
        <p>
          <input
            type="text"
            placeholder="搜点什么吧😋"
            v-model="search_text"
            maxlength="19"
            @keydown.enter="search_trade"
            @input="filter_s"
          />
          <i class="yumao icon-sousuo" @click="search_trade"></i>
          <i class="yumao icon-dacha" @click="search_cancel"></i>
        </p>
      </div>
      <div class="right">
        <em
          v-for="(v, i) in select_filter"
          :key="i"
          :class="i == select_filter_index ? 'selected' : ''"
          @click="set_select_filter(v, i)"
          >{{ v }}</em
        >
      </div>
    </div>
    <div class="content">
      <div class="header">
        <p class="tag_01"><em>编号</em></p>
        <p class="tag_02"><em>单位</em></p>
        <p class="tag_03"><em>介绍</em></p>
        <p class="tag_04"><em>负责</em></p>
        <p class="tag_05"><em>订单状态</em></p>
        <p class="tag_06"><em>评论状态</em></p>
        <p class="tag_07"><em>操作</em></p>
      </div>
      <div class="main">
        <div :id="'trade_' + v.id" v-for="v in data" :key="v">
          <p class="tag_01">
            <em>{{ v.time }}</em>
          </p>
          <p class="tag_02">
            <em>{{ v.user_name }}</em>
          </p>
          <p class="tag_03">
            <em> {{ v.food_name }}</em>
          </p>
          <p class="tag_04">
            <em> {{ v.estimate_content }}</em>
          </p>
          <p class="tag_05">
            <em :class="v.status == '1' ? 'successed' : 'failed'">
              {{ v.status_text }}</em
            >
          </p>
          <p class="tag_06">
            <em :class="v.estimate == '1' ? 'successed' : 'failed'">
              {{ v.estimate_text }}</em
            >
          </p>
          <p class="tag_07">
            <em class="other_btn" @click="estimate_delete(v)"
              ><i></i><i>{{ v.estimate == "1" ? "删除评论" : "" }}</i></em
            >
          </p>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { indexStore } from "~/store";
import { adminStore } from "~/store/admin";
import { storeToRefs } from "pinia";
import api from "~/axios/admin";

let data = ref(await api.get_all_trade());
let select_filter = ref([
  "订单已完成",
  "订单未完成",
  "评论已发布",
  "评论未发布",
  "取消检索",
]);
let select_filter_index = ref(4);
let search_text = ref("");

let set_select_filter = async (type, i) => {
  select_filter_index.value = i;
  let filter_data = await api.filter_trade(type);
  if (filter_data.length) data.value = filter_data;
  else alert("无数据😥");
};

let search_trade = async () => {
  if ((await api.search_trade(search_text.value)).length)
    data.value = await api.search_trade(search_text.value);
  else alert("搜索无结果 🤡");
};
let search_cancel = async () => {
  data.value = await api.get_all_trade();
  search_text.value = "";
};
let estimate_delete = async (v) => {
  if (confirm("确定删除🧐？")) {
    await api.estimate_delete(v);
    alert("删除成功");
  }
};
let filter_s = async () => {
  search_text.value = search_text.value.replace(/\s+/g, "");
};
</script>

<style lang="less">
#TradeSet {
  > .title {
    width: 95%;
    height: 60px;
    border-bottom: 1px solid rgba(210, 199, 199, 0.4);
    margin: 10px auto 10px auto;
    margin-bottom: 6px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    > div {
      width: 48%;
      height: 80%;
    }
    .left {
      p {
        display: flex;
        align-items: center;
        height: 35px;
        width: 260px;
        border: 1px solid rgba(224, 213, 213, 0.4);
        border-radius: 2px;
        transition: all 0.5s;
        &:hover {
          border: 1px solid rgba(178, 170, 170, 0.4);
        }
        input {
          width: 73%;
          font-size: 17px;
          margin-left: 14px;
          color: rgb(71, 69, 69);
        }
        i {
          color: rgb(112, 110, 110);
          margin-left: 7px;
          cursor: pointer;
        }
        input::-webkit-input-placeholder {
          font-size: 15px;
        }
      }
    }
    .right {
      display: flex;
      justify-content: flex-end;
      align-items: center;
      // border: 1px solid gray;
      em {
        margin-left: 20px;
        height: 20px;
        cursor: pointer;
        font-size: 15px;
        transition: all 0.5s;
        border-bottom: 1px solid transparent;
      }
      .selected {
        border-bottom: 1px solid rgb(92, 191, 230);
      }
    }
  }
  .content {
    width: 95%;
    margin: 0 auto;
    .header {
      display: flex;
      width: 100%;
      border-bottom: 1px solid rgb(233, 229, 229);
      border-radius: 1.5px;
      margin-bottom: 10px;
      p {
        height: 35px;
        line-height: 35px;
        padding: 0 10px;
        background: rgb(250, 250, 250);
      }
    }
    .main {
      width: 100%;
      height: 60vh;
      overflow: auto;
      > div[id^="trade_"] {
        display: flex;
        width: 100%;
        border-bottom: 1px solid rgb(245, 240, 255);
        height: 45px;
        display: flex;
        align-items: center;
        transition: all 0.5s;
        background: white;
        &:hover {
          border-bottom: 1px solid rgb(230, 230, 230);
          background: rgb(248, 248, 248);
        }
        > p {
          display: flex;
          padding: 0 10px;
          height: 35px;
          line-height: 35px;
          em {
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
          }
        }
        > p:last-child {
          display: flex;
          align-items: center;
          justify-content: flex-start;
          em {
            margin-right: 18px;
            cursor: pointer;
            height: 25px;
            line-height: 27px;
            font-size: 15px;
            border-radius: 2px;
            transition: all 0.5s;
            opacity: 0.9;
            &:hover {
              opacity: 1;
              color: rgb(38, 169, 220);
            }
          }
        }
      }
    }
    .tag_01 {
      width: 12%;
    }
    .tag_02 {
      width: 12%;
    }
    .tag_03 {
      width: 12%;
    }
    .tag_04 {
      width: 12%;
    }
    .tag_05 {
      width: 12%;
    }
    .tag_06 {
      width: 12%;
    }
  }
  .successed {
    color: green;
  }
  .failed {
    color: red;
  }
}
</style>