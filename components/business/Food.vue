<template>
  <div id="components_business_food">
    <div class="header">
      <div class="left">
        <p>
          <input
            type="text"
            placeholder="搜点什么吧 😅"
            v-model="search_text"
            @keyup.enter="search_food"
          />
          <i class="yumao icon-sousuo" @click="search_food"></i>
          <i class="yumao icon-dacha" @click="search_cancel"></i>
        </p>
      </div>
      <div class="right">
        <i @click="add_one_food">添加单个岗位</i>
        <!-- <i @click="add_file_food">文件批量添加岗位</i> -->
        <!-- <i @click="write_all_food">导出所有岗位</i> -->
        <!-- <i class="look_format" @click="mask_add_format = true"
          >查看文件内容格式</i
        > -->
        <input
          type="file"
          id="inp_file"
          style="display: none"
          @change="change_inp"
        />
      </div>
    </div>
    <div class="content">
      <div class="title">
        <em class="title_01">编号号码</em>
        <em class="title_02">招聘岗位</em>
        <em class="title_03">岗位要求</em>
        <em class="title_04">岗位介绍</em>
        <em class="title_05">发布时间</em>
        <em class="title_06">编辑操作</em>
      </div>
      <div class="main">
        <div :class="'order_' + v.id" v-for="(v, i) in test_data" :key="i">
          <p class="tag_01">
            <i>{{v.id}}</i>
          </p>
          <p class="tag_02">
            <i>{{v.pos}}</i>
          </p>
          <p class="tag_03">
            <i>{{v.reques}}</i>
          </p>
          <p class="tag_04">
            <i>{{v.introduce}}</i>
          </p>
          <p class="tag_05" @click="show_estimate(v)">
            <i>{{v.time}}</i>
          </p>
           <p class="tag_06" @click="show_estimate(v)">
            <i style="color: red;cursor: pointer;">删除</i>
            <i style="color: green;cursor: pointer;">编辑</i>
          </p>
        </div>
      </div>
    </div>
     <Transition name="show_resume" tip="estimate" mode="out-in">
       <div class="add_one_food" v-show="mask_add_one">
      <div class="back" @click="mask_add_one = false"></div>
      <div class="main">
        <input
          type="file"
          id="add_food_inp"
          style="display: none"
          @change="show_select_img"
        />
        <!-- <div class="img_main">
          <img :src="pre_select_img" @click="emit_select_img" />
        </div> -->
        <div class="double_item">
          <p>
            <i>名称</i
            ><input
              type="text"
              placeholder="名称"
              v-model="add_food_data.name"
            />
          </p>
          <p>
            <i>岗位</i
            ><input
              type="text"
              placeholder="岗位"
              v-model="add_food_data.detail"
            />
          </p>
        </div>
        <div class="double_item">
          <p>
            <i>要求</i
            ><input
              type="text"
              placeholder="要求"
              v-model="add_food_data.introduce"
            />
          </p>
          <p>
            <i>描述</i
            ><input
              type="text"
              placeholder="描述"
              v-model="add_food_data.price"
            />
          </p>
        </div>
        <div class="footer_fn"><i @click="sure_add_food">添加</i></div>
      </div>
    </div>
    </Transition>


    <div class="look_format_food" v-if="mask_add_format">
      <div class="back" @click="mask_add_format = false"></div>
      <div class="main">
        <p><img src="/images/xlsx.jpg" alt="" /></p>
      </div>
    </div>
  </div>
</template>
  
  
  <script setup>
import { businessStore } from "~/store/business";
import { storeToRefs } from "pinia";
import _ from "lodash";
import business_api from "~/axios/business";
import readFileXlsx from "read-excel-file";
import writeFileXlsx from "write-excel-file";
let { data_business } = storeToRefs(businessStore());

let data = ref(await business_api.get_food());
let test_data = [
  {id:10212,pos:'大学辅导员',reques:'大学本科，共青团员',introduce:'辅导学生全方面的技能扩展，完成日常任务',time:'2024-12-12 12:12:00'},
  {id:10213,pos:'图书管理员',reques:'大学专科，共青团员',introduce:'辅导学生全方面的技能扩展，完成日常任务',time:'2024-12-12 12:12:00'},
  {id:10214,pos:'大学副教授',reques:'大学本科，共青团员',introduce:'辅导学生全方面的技能扩展，完成日常任务',time:'2024-12-12 12:12:00'},
  {id:10215,pos:'食堂管理员',reques:'大学本科，共青团员',introduce:'辅导学生全方面的技能扩展，完成日常任务',time:'2024-12-12 12:12:00'},
  {id:10216,pos:'大学辅导员',reques:'大学本科，共青团员',introduce:'辅导学生全方面的技能扩展，完成日常任务',time:'2024-12-12 12:12:00'},
  {id:10217,pos:'图书管理员',reques:'大学本科，共青团员',introduce:'辅导学生全方面的技能扩展，完成日常任务',time:'2024-12-12 12:12:00'},
  {id:10218,pos:'食堂管理员',reques:'大学本科，共青团员',introduce:'辅导学生全方面的技能扩展，完成日常任务',time:'2024-12-12 12:12:00'},
  {id:10219,pos:'大学辅导员',reques:'大学本科，共青团员',introduce:'辅导学生全方面的技能扩展，完成日常任务',time:'2024-12-12 12:12:00'},
  {id:10210,pos:'图书管理员',reques:'大学本科，共青团员',introduce:'辅导学生全方面的技能扩展，完成日常任务',time:'2024-12-12 12:12:00'},
  {id:10211,pos:'大学副教授',reques:'大学本科，共青团员',introduce:'辅导学生全方面的技能扩展，完成日常任务',time:'2024-12-12 12:12:00'},

];
let search_text = ref("");
let mask_add_one = ref(false);
let mask_add_format = ref(false);
let add_food_data = ref({ name: "", detail: "", introduce: "", price: "" });
let pre_select_img = ref("images/food_1.jpg");
let file_food = ref("");

let search_food = async () => {
  let search_data = await business_api.search_food(search_text.value);
  if (search_data.length) {
    data.value = await business_api.search_food(search_text.value);
  } else alert("无数据 😀");
};
let search_cancel = async () => {
  let search_data = await business_api.get_food();
  data.value = search_data;
  search_text.value = "";
};
let add_one_food = () => {
  mask_add_one.value = true;
};
let add_file_food = () => {
  let inpDom = document.getElementById("inp_file");
  inpDom.click();
};
let change_inp = async () => {
  let inpDom = document.getElementById("inp_file");
  let temp = inpDom.files[0].name.split(".");
  let type = temp[temp.length - 1];
  if (type != "xlsx") {
    alert("请上传xlsx文件😡");
    inpDom.value = "";
    return 0;
  }
  readFileXlsx(inpDom.files[0]).then(async (rows) => {
    await business_api.add_file_food(rows);
    data.value = await business_api.get_food();
    alert("添加成功！🥰");
  });
  inpDom.value = "";

  // let data = await business_api.add_file_food)
};
let emit_select_img = () => {
  document.getElementById("add_food_inp").click();
};
let show_select_img = () => {
  let inpdom = document.getElementById("add_food_inp");
  file_food.value = inpdom.files[0];
  if (file_food.value)
    pre_select_img.value = URL.createObjectURL(file_food.value);
};
let sure_add_food = async () => {
  if (!file_food.value) {
    alert("请选择食物图片 🤡");
    return;
  }
  let formData = new FormData();
  formData.append("files", file_food.value);
  formData.append("food", JSON.stringify(add_food_data.value));
  await business_api.add_one_food(formData);
  alert("添加成功！🥰");
  mask_add_one.value = false;
  file_food.value = "";
  data.value = await business_api.get_food();
};
let write_all_food = async () => {
  let header_row = [
    { value: "ID" },
    { value: "菜品" },
    { value: "配料" },
    { value: "介绍" },
    { value: "价格" },
  ];
  let write_data = [header_row];
  for (let i = 1; i < data.value.length; i++) {
    let row = [];
    row.push({ value: data.value[i - 1].id });
    row.push({ value: data.value[i - 1].name });
    row.push({ value: data.value[i - 1].detail });
    row.push({ value: data.value[i - 1].introduce });
    row.push({ value: data.value[i - 1].price });
    write_data.push(row);
  }
  await writeFileXlsx(write_data, {
    fileName: data_business.value.name + "(所有菜品).xlsx",
  }); 
};
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
#components_business_food {
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
        border: 1px solid rgb(229, 222, 222);
        transition: all 0.5s;
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
        color: rgb(48, 46, 46);
        transition: all 0.5s;
        margin-left: 25px;
      }
      .look_format {
        color: rgb(198, 195, 195);
      }
    }
  }
  .content {
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
        width: 8%;
      }
      .title_02 {
        width: 10%;
      }
      .title_03 {
        width: 16%;
      }
      .title_04 {
        width: 30%;
      }
      .title_05 {
        width: 15%;
      }
      .title_06 {
        width: 10%;
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
          width: 8%;
        }
        .tag_02 {
          width: 10%;
        }
        .tag_03 {
          width: 16%;
        }
        .tag_04 {
          width: 30%;
        }
        .tag_05 {
          width: 15%;
        }
        .tag_06 {
          width: 10%;
        }

        > p {
          margin-right: 20px;
          display: flex;
          align-items: center;
          i {
            width: 100%;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
          }
        }
      }
    }
  }
  .add_one_food {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(189, 187, 187, 0.7);
    .back {
      width: 100%;
      height: 100%;
    }
    .main {
      position: absolute;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      height: 300px;
      width: 370px;
      background: white;
      border-radius: 1px;
     
      .double_item {
        display: flex;
        width: 90%;
        margin: 60px auto 45px auto;
        // border: 1px solid gray;
        p {
          height: 40px;

          i {
            font-size: 14px;
          }
          input {
            height: 28px;
            padding: 0 10px;
            margin-top: 6px;
            border: 1px solid rgb(231, 225, 225);
          }
        }
      }
      .footer_fn {
        width: 85%;
        margin: 0 auto;
        display: flex;
        justify-content: flex-end;
        i {
          cursor: pointer;
          transition: all 0.5s;
          color: rgb(158, 156, 156);
          margin-left: 25px;
          &:hover {
            color: rgb(67, 186, 234);
          }
        }
      }
    }
  }
  .look_format_food {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(189, 187, 187, 0.7);
    .back {
      width: 100%;
      height: 100%;
    }
    .main {
      position: absolute;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      height: 200px;
      width: 500px;
      background: white;
      border-radius: 1px;
      display: flex;
      justify-content: center;
      align-items: center;
      p {
        text-align: center;
      }
      img {
        width: 90%;
      }
    }
  }
}
.add_one_food-enter-active,
.add_one_food-leave-active {
  transition: all 0.5s;
}
.add_one_food-enter-to,
.add_one_food-leave-from {
  opacity: 0;
  filter: blur(1px);
}
</style>