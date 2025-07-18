<template>
  <div>
    <p>write-xlsx测试</p>
  </div>
</template>

<script setup>
import writeXlsxFile from "write-excel-file";

let header_data = [{ value: "名字" }, { value: "年龄" }];
let rows_1 = [{ value: "羽毛" }, { value: 32 }];
let rows_2 = [{ value: "华落" }, { value: 43 }];
let data = [header_data, rows_1, rows_2];
// console.log(writeXlsxFile);
await writeXlsxFile(data, {
  fileName: "write_xlsx",
});
</script>