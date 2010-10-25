-- This file was created by and is modified by Ion.

initialise_screen_id(0, {
    type = "WScreen",
    name = "WScreen",
    subs = {
        {
            type = "WIonWS",
            name = "main",
            split_tree = {
                type = "WIonFrame",
                name = "WIonFrame",
                flags = 0,
                subs = {
                },
            },
        },
        {
            type = "WIonWS",
            name = "WIonWS",
            split_tree = {
                type = "WIonFrame",
                name = "WIonFrame<1>",
                flags = 0,
                subs = {
                },
            },
        },
        {
            type = "WIonWS",
            split_tree = {
                type = "WIonFrame",
                name = "WIonFrame<2>",
                flags = 0,
                subs = {
                },
            },
        },
        {
            type = "WIonWS",
            name = "WIonWS<1>",
            split_tree = {
                split_dir = "horizontal",
                split_tls = 640, split_brs = 640,
                tl = {
                    type = "WIonFrame",
                    name = "WIonFrame<3>",
                    flags = 16,
                    saved_x = 0, saved_w = 1280,
                    subs = {
                        {
                            type = "WClientWin",
                            windowid = 16777225,
                            checkcode = 1,
                            switchto = true,
                        },
                    },
                },
                br = {
                    split_dir = "vertical",
                    split_tls = 400, split_brs = 400,
                    tl = {
                        type = "WIonFrame",
                        name = "WIonFrame<9>",
                        flags = 8,
                        saved_y = 0, saved_h = 800,
                        subs = {
                            {
                                type = "WClientWin",
                                windowid = 16783464,
                                checkcode = 2,
                                switchto = true,
                            },
                        },
                    },
                    br = {
                        type = "WIonFrame",
                        name = "WIonFrame<10>",
                        flags = 0,
                        subs = {
                            {
                                type = "WClientWin",
                                windowid = 16783623,
                                checkcode = 3,
                                switchto = true,
                            },
                        },
                    },
                },
            },
        },
        {
            type = "WIonWS",
            name = "WIonWS<2>",
            split_tree = {
                type = "WIonFrame",
                name = "WIonFrame<4>",
                flags = 0,
                subs = {
                    {
                        type = "WClientWin",
                        windowid = 18874679,
                        checkcode = 4,
                        switchto = true,
                    },
                },
            },
            switchto = true,
        },
        {
            type = "WIonWS",
            name = "WIonWS<3>",
            split_tree = {
                split_dir = "horizontal",
                split_tls = 640, split_brs = 640,
                tl = {
                    type = "WIonFrame",
                    name = "WIonFrame<5>",
                    flags = 16,
                    saved_x = 0, saved_w = 1280,
                    subs = {
                        {
                            type = "WClientWin",
                            windowid = 16871558,
                            checkcode = 5,
                            switchto = true,
                        },
                    },
                },
                br = {
                    split_dir = "vertical",
                    split_tls = 400, split_brs = 400,
                    tl = {
                        type = "WIonFrame",
                        name = "WIonFrame<11>",
                        flags = 8,
                        saved_y = 0, saved_h = 800,
                        subs = {
                            {
                                type = "WClientWin",
                                windowid = 16871993,
                                checkcode = 6,
                                switchto = true,
                            },
                        },
                    },
                    br = {
                        type = "WIonFrame",
                        name = "WIonFrame<12>",
                        flags = 0,
                        subs = {
                            {
                                type = "WClientWin",
                                windowid = 16897624,
                                checkcode = 7,
                                switchto = true,
                            },
                        },
                    },
                },
            },
        },
        {
            type = "WIonWS",
            name = "WIonWS<4>",
            split_tree = {
                type = "WIonFrame",
                name = "WIonFrame<6>",
                flags = 0,
                subs = {
                },
            },
        },
        {
            type = "WIonWS",
            name = "WIonWS<5>",
            split_tree = {
                type = "WIonFrame",
                name = "WIonFrame<7>",
                flags = 0,
                subs = {
                },
            },
        },
        {
            type = "WIonWS",
            name = "WIonWS<6>",
            split_tree = {
                type = "WIonFrame",
                name = "WIonFrame<8>",
                flags = 0,
                subs = {
                },
            },
        },
    },
})

