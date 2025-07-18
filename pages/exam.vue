<template>
    <div id="pages_exam">
        <p class="title">你的信息</p>
        <p><em>张三峰</em><em>男</em><em>32岁</em><em>博士</em><em>广东科技大学</em><em>计算机科学与技术专业</em><em>图像去噪优化算法方向</em></p>
        <p class="title">{{cs_text}}</p>
        <div class="section_2">
            <p v-for="item in question" :key="item.name">
                <em class="timu">{{item.content}}</em>
                <em class="daan">{{item.answer}}</em>
            </p>
        </div>
    </div>
</template>

<script setup>
let upload_file = ()=>{
document.getElementById('cs').click();
}
import * as echarts from 'echarts';
import OpenAI from "openai";

const openai = new OpenAI({
        baseURL: 'https://api.deepseek.com',
        apiKey: 'sk-5d0fd45ab4224962a56453d10eb5e8ec',
        dangerouslyAllowBrowser: true 
});
async function streamResponse(question, updateCallback) {
    let fullResponse = '';
    try {
        const stream = await openai.chat.completions.create({
            messages: [{ role: "system", content: question }],
            model: "deepseek-chat",
            stream: true,  // 启用流式响应
        });

        for await (const chunk of stream) {
            const content = chunk.choices[0]?.delta?.content || '';
            // content = content.replace("*",'')
            fullResponse += content;
            fullResponse = fullResponse.replace('*','')
            // 更新回调函数，逐字传递内容
            updateCallback(fullResponse);
            
            // 添加微小延迟使逐字效果更明显
            await new Promise(resolve => setTimeout(resolve, 20));
        }
    } catch (error) {
        console.error('流式请求出错:', error);
        updateCallback('请求出错，请重试');
    }
    
    return fullResponse;
}
let gpt_compute = ref("等待测评结果");
let show_resume = ref(1);
let grenerte_graph = (dom)=>{
setTimeout(() => {
var chartDom = document.getElementById(dom);
console.log(chartDom);
    var myChart = echarts.init(chartDom);
var option;

option = {

  radar: {
    // shape: 'circle',
    indicator: [
      { name: '知识水平度', max: 10000 },
      { name: '技能匹配度', max: 10000 },
      { name: '语言表达度', max: 10000 },
      { name: '逻辑思维力', max: 10000 },
      { name: '创新创业力', max: 10000 },
      { name: '应抗压能力', max: 10000 }
    ]
  },
  series: [
    {
      type: 'radar',
      data: [
        {
          value: [3200, 3000, 4000, 4200, 3000, 3500],
          name: '本科阶段'
        },
        {
          value: [6200, 7000, 8000, 7000, 8500, 7000],
          name: '硕士阶段'
        }
      ],
      detail: {
        fontSize: 8,
      }
    }
  ]
};
option && myChart.setOption(option);
}, 1000);

}

let grained_info = async() => {
    show_resume.value = 2;
    grenerte_graph("graph_1");
    await streamResponse('假如在面试，你是面试官，以面试官的口吻评价你的面试者常见微表情、肢体语言分析结果和建议，添加少量emoji,不要出现字数，130-200字', (text) => {
            gpt_compute.value = text;
        });
    cs_text.value = "简历解析完成，点击查看图表 🙌";
}


let cs_text = ref("面试题目#1000题 随机题目来自科大讯飞模型");

let question = [{name:'1',
    content:'1. 什么是图像噪声？列举常见的图像噪声类型及其特点。',
    answer:'图像噪声是指图像中不需要的随机信号干扰，主要类型包括，高斯噪声：符合正态分布，整个图像均匀分布，椒盐噪声：随机出现的黑白像素点（脉冲噪声）'
},{
    name:'2',
    content:'2. 解释均值滤波和中值滤波的原理及适用场景。',
    answer:'均值滤波：用邻域像素平均值替代中心像素值 中值滤波：取邻域像素的中值作为输出'
},{
    name:'3',
    content:'3. 如何利用傅里叶变换进行图像去噪？请说明步骤。',
    answer:'对图像进行二维傅里叶变换得到频谱 分析频谱特征，识别噪声成分（通常高频部分）'
},{
    name:'4',
    content:'4. 解释BM3D去噪算法的核心思想和主要步骤。',
    answer:'BM3D（Block-Matching 3D）是当前最优秀的传统去噪算法之一： 块匹配：找到相似图像块组成3D数组'
},
{
    name:'4',
    content:'5. 比较DnCNN、UNet和GAN在图像去噪中的优缺点。',
    answer:'残差学习有效，结构简单 处理复杂噪声能力有限'
},
{
    name:'4',
    content:'6. 列举图像去噪的客观评价指标并解释PSNR和SSIM的区别。',
    answer:'PSNR（峰值信噪比）：基于MSE的对数度量 SSIM（结构相似性）：考虑亮度、对比度、结构'
},
{
    name:'4',
    content:'7. 医疗CT图像中含有高斯噪声和条纹伪影，如何设计去噪方案？',
    answer:'使用频域滤波（傅里叶/小波域）去除周期性条纹 或采用基于方向的滤波方法'
},
{
    name:'4',
    content:'8. 用Python实现一个简单的高斯噪声添加和去噪流程。',
    answer:'ef add_gaussian_noise(image, mean=0, sigma=25): noisy = image + np.random.normal(mean, sigma, image.shape)'
},
{
    name:'4',
    content:'9. 为什么小波变换比傅里叶变换更适合图像去噪？',
    answer:'多分辨率分析：同时提供时域和频域信息'
},
{
    name:'4',
    content:'10. 解释扩散模型（Diffusion Models）在图像去噪中的原理和应用。',
    answer:'前向过程：逐步添加高斯噪声破坏图像（T步） 反向过程：学习逐步去噪的神经网络'
},
];
onMounted(() => {
   document.body.style.background = "#F2F2F2";
});
useHead({
  title: "行业题目-大语言模型多模态模拟面试智能体系统",
});
</script>

<style lang="less">
.show_resume-enter-active,
.show_resume-leave-active {
  transition: all 0.3s ease; /* 添加 easing 函数使过渡更平滑 */
}

.show_resume-enter-from,
.show_resume-leave-to {
  opacity: 0;
  filter: blur(1px);
}

#pages_exam{
    #graph_1{
        width: 400px;
        height: 300px;
    }
    #graph_2{
        width: 400px;
        height: 300px;
    }
    width: 100%;
    .title{
        width: 60%;
        margin: 60px auto 0 auto;
        font-size: 20px;
        color: #333;
        font-weight: bold;
    }
     >p:nth-of-type(2){
        width: 60%;
        margin: 30px auto 0 auto;
        font-size: 16px;
        font-weight: bold;
        em{
            margin-right: 30px;
        }
    }
   
    .section_2{
        width: 60%;
        margin: 20px auto 0 auto;
        max-height: 500px;
        overflow-y: auto;
        >p{
            display: flex;
            flex-direction: column;
            margin-bottom: 20px;
        }
        .timu{
            margin-bottom: 8px;
            font-size: 18px;
        }
        .daan{
            color: rgb(98, 91, 91);
            margin-right: 20px;
        }
  
    }
}
</style>