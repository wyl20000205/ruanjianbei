<template>
  <div class='flex justify-center items-start text-2xl'><p>typescript tailwindcss</p><p>测试</p></div>
</template>
<script lang="ts" setup>
import { type a4 } from "~/pages/interdace";
interface food {
  name: string;
  price: number;
}
let a: boolean = true;
let a1 = (name: string): number => {
  return 1;
};
// showError("😱 Oh no, an error has been thrown.")
// showError({
//   statusCode: 404,
//   statusMessage: "Page Not Found"
// })
let a3 = ref<a4>({ name: "" });
console.log(a3.value.name);
</script>