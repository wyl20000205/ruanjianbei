import axios from 'axios'
// import {indexStore} from '~/store/index'

// vue文件可用
export let config = () => {
    let url = '127.0.0.1'
    // if (process.env.NODE_ENV == 'development') url = '/init_data'
    let custom_axios = axios.create({ method: "post", baseURL: "http://127.0.0.1:1000/api/v1/index/" })
    // console.log(url);
    
    axios.interceptors.request.use((config) => {
        config.headers.Authorization = '123';
    })
    return {
        async test_axios() {
            let { data } = await custom_axios({ url: '/init_data1' })
            return data
        },
    }
}