<template>
  <div>
    <p>xlsx测试</p>
    <br />
    <input type="file" id="input" @change="changeXlsx" />
  </div>
</template>

<script setup>
import readXlsxFile from "read-excel-file";
import api from "~/axios";

let changeXlsx = () => {
  let inp = document.getElementById("input");
  let temp = inp.files[0].name.split(".");
  let type = temp[temp.length - 1];
  if (type != "xlsx") {
    alert("请上传xlsx文件");
    return 0;
  }
  readXlsxFile(inp.files[0]).then(async (rows) => {
    await api.xlsx(rows);
    inp.value = "";
  });
};
</script>

<style lang="less" scoped>
body {
  height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
}
</style>