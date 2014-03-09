# 图片授权
$warrant = {
    0 => {
        name: '署名-非商业使用-禁止演绎',
        style: [1, 2, 3]
    },
    1 => {
        name: '署名-非商业使用-相同方式共享',
        style: [1, 2, 4]
    },
    2 => {
        name: '署名-非商业使用',
        style: [1, 2, 5]
    },
    3 => {
        name: '署名-禁止演绎',
        style: [1, 3, 5]
    },
    4 => {
        name: '署名-相同方式共享',
        style: [1, 4, 5]
    },
    5 => {
        name: '署名',
        style: [1, 5, 5]
    }
}
$warrantval = Hash[$warrant.map{|k,v|[k,v[:name]]}]