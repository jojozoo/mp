class My::ApplicationController < ApplicationController
    layout 'my'
    before_filter :filter
    def filter
        @datas = {
            'sets' => {
                name: '个人设置',
                icon: 'wrench',
                actions: {
                        basic_my_sets_path => '基本资料', 
                        avatar_my_sets_path => '头像设置',
                        security_my_sets_path => '安全设置',
                        privacy_my_sets_path => '隐私设置',
                        push_my_sets_path => '推送设置',
                        dy_my_sets_path => '动态设置',
                        bg_my_sets_path => '模板设置' 
                    }
            },
            'albums' =>  {
                name: '我的相册',
                icon: 'picture',
                actions: {}
            },
            'works' => {
                name: '我的作品',
                icon: '',
                actions: {}
            },
            'msgs' => {
                name: '漫信&通知',
                icon: 'envelope',
                actions: {
                    mails: {
                        my_msgs_path => '全部漫信',
                        read_my_msgs_path => '已读漫信',
                        unread_my_msgs_path => '未读漫信'
                    },
                    # trash_my_msgs_path => '垃圾漫信',
                    new_my_msg_path => '给关注着写信',
                    notices_my_msgs_path => '网站通知'
                }
            },
            'timelines' => {
                name: '时间轴',
                icon: 'time',
                actions: {}
            },
            'follows' => {
                name: '粉丝&关注',
                icon: '',
                actions: {}
            },
            'events' => {
                name: '活动',
                icon: '',
                actions: {}
            },
            'groups' => {
                name: '圈子',
                icon: '',
                actions: {}
            },
            'inters' => {
                name: '我的互动(点赞,推荐,喜欢,收藏)',
                icon: '',
                actions: {}
            },
            'other_sites' => {
                name: '同步其他网站',
                icon: '',
                actions: {}
            }
        }
    end

end