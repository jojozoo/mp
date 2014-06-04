
function () {
        var e, t = function (e, t) {
            return function () {
                return e.apply(t, arguments)
            }
        },
            i = {}.hasOwnProperty,
            n = function (e, t) {
                function n() {
                    this.constructor = e
                }
                for (var s in t) i.call(t, s) && (e[s] = t[s]);
                return n.prototype = t.prototype,
                e.prototype = new n,
                e.__super__ = t.prototype,
                e
            };
        PxApp.Views.Tags.Field = function (i) {
                function s() {
                    return this.render = t(this.render, this),
                    this.tag_entered = t(this.tag_entered, this),
                    this.update_placeholder = t(this.update_placeholder, this),
                    this.update_remaining_count = t(this.update_remaining_count, this),
                    this.add_tag = t(this.add_tag, this),
                    this.resize_input = t(this.resize_input, this),
                    this.blur_field = t(this.blur_field, this),
                    this.focus_field = t(this.focus_field, this),
                    this.current_value = t(this.current_value, this),
                    this.update_selected_tag = t(this.update_selected_tag, this),
                    this.hide_input = t(this.hide_input, this),
                    this.remove_tag = t(this.remove_tag, this),
                    this.reset_tags = t(this.reset_tags, this),
                    this.remove_tag_element = t(this.remove_tag_element, this),
                    this.focus_input = t(this.focus_input, this),
                    this.stop_event_unless_input = t(this.stop_event_unless_input, this),
                    this.handle_input_keypress = t(this.handle_input_keypress, this),
                    e = s.__super__.constructor.apply(this, arguments)
                }
                return n(s, i),
                s.prototype.initialize = function (e) {
                    return this.collection = e.collection,
                    this.collection.bind("add", this.add_tag),
                    this.collection.bind("remove", this.remove_tag),
                    this.collection.bind("reset", this.reset_tags),
                    this.collection.bind("select", this.update_selected_tag),
                    this.collection.bind("deselect", this.update_selected_tag),
                    this.collection.on("add remove", this.update_remaining_count),
                    this.setElement(this.options.el),
                    this.global_tag_candidates = e.global_tag_candidates,
                    this.global_tag_candidates || (this.global_tag_candidates = new PxApp.Collections.TagSuggestions, this.global_tag_candidates.fetch()),
                    this.user_tag_candidates = e.user_tag_candidates,
                    this.user_tag_candidates ? void 0 : (this.user_tag_candidates = new PxApp.Collections.TagSuggestions([], {
                        user_id: PxApp.current_user.id
                    }), this.user_tag_candidates.fetch())
                },
                s.prototype.events = {
                    "focus .tag_field input": "focus_field",
                    "blur .tag_field input": "blur_field",
                    "click .tag .remove": "remove_tag_element",
                    "keydown .tag_field input": "handle_input_keypress",
                    mousedown: "stop_event_unless_input",
                    dragstart: "stop_event_unless_input",
                    click: "focus_input"
                },
                s.prototype.handle_input_keypress = function (e) {
                    var t, i, n, s;
                    return i = 0 === e.target.selectionStart,
                    t = void 0 !== this.collection.selected_index,
                    n = e.target.selectionStart !== e.target.selectionEnd,
                    i && e.which === this.KEYS.left ? (this.collection.select_previous(), e.stop()) : t && e.which === this.KEYS.right ? (this.collection.select_next(), e.stop()) : t && e.which === this.KEYS.del ? (s = this.collection.selected_index, this.collection.remove(this.collection.selected), this.collection.deselect(), this.collection.select_index(s), e.stop()) : t && e.which === this.KEYS.backspace && !n ? (s = this.collection.selected_index, s -= 1, this.collection.remove(this.collection.selected), this.collection.deselect(), s >= 0 && this.collection.select_index(s), e.stop()) : i && e.which === this.KEYS.backspace && !n ? (this.collection.select_previous(), e.stop()) : this.collection.selected ? (this.collection.deselect(), !0) : void 0
                },
                s.prototype.stop_event_unless_input = function (e) {
                    return "INPUT" !== e.target.tagName ? e.stop() : void 0
                },
                s.prototype.focus_input = function () {
                    return this.collection.deselect(),
                    this.input.removeAttr("disabled").focus(),
                    this.resize_input()
                },
                s.prototype.remove_tag_element = function (e) {
                    var t, i;
                    return t = $(e.target).closest(".tag").attr("data-cid"),
                    i = _.select(this.collection.models, function (e) {
                        return e.cid === t
                    }),
                    this.collection.remove(i),
                    this.focus_input()
                },
                s.prototype.reset_tags = function () {
                    var e = this;
                    return this.$(".tag").remove(),
                    this.collection.each(function (t) {
                        return e.add_tag(t)
                    })
                },
                s.prototype.remove_tag = function (e) {
                    return this.$(".tag[data-cid='" + e.cid + "']").remove(),
                    this.input.width(1),
                    this.resize_input(),
                    this.update_placeholder()
                },
                s.prototype.hide_input = function () {},
                s.prototype.update_selected_tag = function () {
                    return this.$(".tag").removeClass("selected"),
                    this.collection.selected ? (this.selected_element().addClass("selected"), this.hide_input()) : void 0
                },
                s.prototype.current_value = function () {
                    return this.trim_tag(this.input.val())
                },
                s.prototype.trim_tag = function (e) {
                    return e = e.replace(/^[#,\s]*(.*?)\s*$/, "$1"),
                    e.slice(0, 45)
                },
                s.prototype.add_current_value_to_collection = function () {
                    var e, t, i, n, s;
                    for (i = this.current_value().split(/[,#]+/), n = 0, s = i.length; s > n; n++) e = i[n],
                    e = this.trim_tag(e),
                    e && (0 === this.user_tag_candidates.where({
                        name: e
                    }).length && (t = new PxApp.Models.Tag({
                        name: e
                    }, {
                        taggable_model: null
                    }), this.user_tag_candidates.add(t, {
                        at: 0
                    })), this.collection.add({
                        name: e
                    }));
                    return this.input.val("")
                },
                s.prototype.focus_field = function () {
                    return this.$el.addClass("focused"),
                    this.auto_completion.clear_suggestions()
                },
                s.prototype.blur_field = function () {
                    return "" !== this.current_value() && this.add_current_value_to_collection(),
                    this.$el.removeClass("focused"),
                    this.auto_completion.clear_suggestions()
                },
                s.prototype.resize_input = function () {
                    var e, t, i, n, s, a;
                    return n = this.$(".tag_field"),
                    e = this.input,
                    s = this.$el.position().left,
                    a = this.$el.width() - 10,
                    t = e.position().left,
                    i = a - (t - s),
                    100 > i && (i = a),
                    e.width(i)
                },
                s.prototype.add_tag = function (e) {
                    var t, i;
                    return i = this.input,
                    i.width(1),
                    t = render("tags/tag", e.toJSON()),
                    $(t).attr("data-cid", e.cid),
                    this.$(".tag_field").before(t),
                    this.update_placeholder(),
                    this.resize_input()
                },
                s.prototype.update_remaining_count = function () {
                    var e, t, i;
                    return t = this.$el.parent().find(".tag-count"),
                    i = this.collection.models.length,
                    30 === i ? this.$(".tag_field").hide() : 29 === i && (this.$(".tag_field").show(), this.resize_input()),
                    i > 30 ? (e = PxApp.locale.upload.photo_details.fields.tags.none_remaining, t.text(e)) : i >= 20 && 30 >= i ? (e = "" + (30 - i) + " " + PxApp.locale.upload.photo_details.fields.tags.remaining, t.text(e)) : 20 > i ? t.text("") : void 0
                },
                s.prototype.update_placeholder = function () {
                    return this.collection.models.length > 1 ? this.$(".tag_field input").attr("placeholder", PxApp.locale.upload.photo_details.fields.tags.short_placeholder) : this.$(".tag_field input").attr("placeholder", PxApp.locale.upload.photo_details.fields.tags.placeholder)
                },
                s.prototype.tag_entered = function (e) {
                    var t, i;
                    return t = this.auto_completion.get_selected_tag(),
                    t && (PxApp.GA.event({
                        category: "Upload Page",
                        action: "Tag suggestion",
                        label: t,
                        value: this.current_value().length
                    }), this.input.val(t)),
                    this.auto_completion.clear_suggestions(),
                    i = this.current_value(),
                    "" !== i && this.collection.models.length < 30 && this.add_current_value_to_collection(),
                    null != e ? e.stop() : void 0
                },
                s.prototype.render = function () {
                    var e = this;
                    return this.input = this.$(".tag_field input"),
                    this.auto_completion = new PxApp.Views.Tags.Field.AutoCompletion({
                        parent: this,
                        input: this.input,
                        global_tag_candidates: this.global_tag_candidates,
                        user_tag_candidates: this.user_tag_candidates,
                        existing_tags: this.collection
                    }),
                    this.auto_completion.bind("dropdown:show", function () {
                        return e.$el.addClass("ac_attached")
                    }),
                    this.auto_completion.bind("dropdown:hide", function () {
                        return e.$el.removeClass("ac_attached")
                    }),
                    this.auto_completion.render(),
                    this.input.on("keydown", function (t) {
                        return e.handle_keydown(t)
                    }),
                    this.input.on("keypress", function (t) {
                        return e.handle_keypress(t)
                    }),
                    this.reset_tags(),
                    this
                },
                s.prototype.activate = function () {
                    var e = this;
                    return _.defer(function () {
                        return e.resize_input()
                    }),
                    this
                },
                s.prototype.handle_keypress = function (e) {
                    var t, i, n;
                    return n = e.which,
                    i = "#".charCodeAt(0),
                    t = ",".charCodeAt(0),
                    n !== i && n !== t || (this.tag_entered(), n === i) ? void 0 : e.stop()
                },
                s.prototype.handle_keydown = function (e) {
                    var t;
                    return t = e.which,
                    t === this.KEYS["return"] || t === this.KEYS.tab ? (e.stop(), this.tag_entered()) : t === this.KEYS.escape ? (e.stop(), this.auto_completion.clear_suggestions(e)) : t === this.KEYS.up ? (e.stop(), this.auto_completion.move_up(e)) : t === this.KEYS.down ? (e.stop(), this.auto_completion.move_down(e)) : void 0
                },
                s
            }(Backbone.View)
    }.call(this),


function () {
        var e, t = function (e, t) {
            return function () {
                return e.apply(t, arguments)
            }
        },
            i = {}.hasOwnProperty,
            n = function (e, t) {
                function n() {
                    this.constructor = e
                }
                for (var s in t) i.call(t, s) && (e[s] = t[s]);
                return n.prototype = t.prototype,
                e.prototype = new n,
                e.__super__ = t.prototype,
                e
            };
        PxApp.Views.Tags.Field.AutoCompleteItem = function (i) {
                function s() {
                    return this.unhighlight = t(this.unhighlight, this),
                    this.highlight = t(this.highlight, this),
                    this.select = t(this.select, this),
                    e = s.__super__.constructor.apply(this, arguments)
                }
                return n(s, i),
                s.prototype.template = "tags/auto_completion_item",
                s.prototype.separator_template = "tags/auto_completion_separator",
                s.prototype.initialize = function (e) {
                    return this.matched = e.matched,
                    this.tag = e.tag,
                    this.parent = e.parent
                },
                s.prototype.render = function () {
                    var e, t, i, n, s;
                    return this.tag === this.parent.TAG_SEPARATOR ? (i = render(this.separator_template), this.setElement(i)) : (s = this.tag.get("name"), n = this.matched.length, e = {
                        tag_matched: this.matched,
                        tag_remaining: s.substr(n)
                    }, t = {
                        tag_matched: {
                            text: function () {
                                return this.tag_matched
                            }
                        },
                        tag_remaining: {
                            text: function () {
                                return this.tag_remaining
                            }
                        }
                    }, i = render(this.template, e, t), this.setElement(i))
                },
                s.prototype.events = {
                    mousedown: "select",
                    mouseover: "highlight",
                    mouseout: "unhighlight"
                },
                s.prototype.select = function (e) {
                    return e.stop(),
                    this.tag !== this.parent.TAG_SEPARATOR ? this.parent.select(this) : void 0
                },
                s.prototype.highlight = function () {
                    return this.parent.highlight(this)
                },
                s.prototype.unhighlight = function () {
                    return this.parent.unhighlight(this)
                },
                s
            }(Backbone.View)
    }.call(this),


function () {
        var e, t = {}.hasOwnProperty,
            i = function (e, i) {
                function n() {
                    this.constructor = e
                }
                for (var s in i) t.call(i, s) && (e[s] = i[s]);
                return n.prototype = i.prototype,
                e.prototype = new n,
                e.__super__ = i.prototype,
                e
            };
        PxApp.Views.Tags.Field.AutoCompletion = function (t) {
                function n() {
                    return e = n.__super__.constructor.apply(this, arguments)
                }
                return i(n, t),
                n.prototype.TAG_SEPARATOR = "-",
                n.prototype.className = "tags_autocompletion_wrap",
                n.prototype.min_characters = 2,
                n.prototype.max_num_results_shown = 8,
                n.prototype.wait_time = !1,
                n.prototype.current_keyword = "",
                n.prototype.initialize = function (e) {
                    return this.parent = e.parent,
                    this.input = e.input,
                    this.global_tag_candidates = e.global_tag_candidates,
                    this.user_tag_candidates = e.user_tag_candidates,
                    this.existing_tags = e.existing_tags,
                    e.min_characters && (this.min_characters = e.min_characters),
                    e.max_num_results_shown && (this.max_num_results_shown = e.max_num_results_shown),
                    e.wait_time && (this.wait_time = e.wait_time),
                    this.wait_time ? this.filter = _.debounce(this.filter, this.wait_time) : void 0
                },
                n.prototype.render = function () {
                    var e = this;
                    return this.input.attr("autocomplete", "off"),
                    this.input.on("keyup", function (t) {
                        return e.keyup(t)
                    }),
                    this.parent.$el.after(this.$el)
                },
                n.prototype.keyup = function (e) {
                    var t, i;
                    if (e.keyCode !== this.KEYS.escape) return i = this.parent.current_value(),
                    t = i.toLowerCase(),
                    this.is_changed(t) || this.$el.is(":hidden") ? this.is_valid(t) ? this.filter(t, i) : (this.$el.empty(), this.hide()) : void 0
                },
                n.prototype.get_downcased_used_tags = function () {
                    var e, t, i, n, s;
                    for (t = {}, s = this.existing_tags.models, i = 0, n = s.length; n > i; i++) e = s[i],
                    t[e.get("name").toLowerCase()] = 1;
                    return t
                },
                n.prototype.filter = function (e, t) {
                    var i, n, s, a, o, r, l, d, c, p, u;
                    for (o = this.get_downcased_used_tags(), i = [], p = this.user_tag_candidates.models, r = 0, d = p.length; d > r; r++) a = p[r],
                    n = a.get("name").toLowerCase(),
                    0 !== n.indexOf(e) || o[n] || (i.push(a), o[n] = 1);
                    for (s = [this.TAG_SEPARATOR], u = this.global_tag_candidates.models, l = 0, c = u.length; c > l; l++) a = u[l],
                    n = a.get("name").toLowerCase(),
                    0 !== n.indexOf(e) || o[n] || (s.push(a), o[n] = 1);
                    return s.length > 1 && (i = i.concat(s)),
                    this.load_suggestions(i, e, t)
                },
                n.prototype.is_valid = function (e) {
                    return e.length >= this.min_characters
                },
                n.prototype.is_changed = function (e) {
                    return this.current_keyword !== e
                },
                n.prototype.move_up = function (e) {
                    return this.move_selection(-1),
                    e.stop()
                },
                n.prototype.move_down = function (e) {
                    return this.move_selection(1),
                    e.stop()
                },
                n.prototype.move_selection = function (e) {
                    var t, i, n;
                    return i = this.$el.children(),
                    i.length > 0 ? (n = this.$el.children(".selected"), t = n.length > 0 ? n.first().index() : -1, t + e < i.length && (t += e), n.removeClass("selected"), t >= 0 && i.eq(t).addClass("selected"), this.$el.find(".tag_suggestion_separator.selected").length > 0 ? this.move_selection(e) : void 0) : void 0
                },
                n.prototype.load_suggestions = function (e, t, i) {
                    var n, s, a, o, r;
                    if (this.current_keyword = t, this.results = e.slice(0, this.max_num_results_shown), this.$el.empty(), this.results.length > 0) {
                        for (n = this.results.length, this.results[n - 1] === this.TAG_SEPARATOR && this.results.pop(), r = this.results, a = 0, o = r.length; o > a; a++) s = r[a],
                        this.add_tag(s, i);
                        return this.$el.children().first().addClass("first"),
                        this.$el.children().last().addClass("last"),
                        this.show()
                    }
                    return this.hide()
                },
                n.prototype.add_tag = function (e, t) {
                    var i;
                    return i = new PxApp.Views.Tags.Field.AutoCompleteItem({
                        matched: t,
                        tag: e,
                        parent: this
                    }),
                    i.render(),
                    this.$el.append(i.$el)
                },
                n.prototype.select = function (e) {
                    return this.$el.children(".selected").removeClass("selected"),
                    e.$el.addClass("selected"),
                    this.parent.tag_entered(),
                    this.input.focus()
                },
                n.prototype.highlight = function (e) {
                    return this.$el.children(".selected").removeClass("selected"),
                    e.$el.addClass("selected")
                },
                n.prototype.unhighlight = function (e) {
                    return e.$el.removeClass("selected")
                },
                n.prototype.get_selected_tag = function () {
                    var e;
                    return e = this.$el.find(".selected"),
                    e.length > 0 ? e.first().text().trim() : void 0
                },
                n.prototype.hide = function () {
                    return this.$el.hide(),
                    this.trigger("dropdown:hide")
                },
                n.prototype.show = function () {
                    return this.$el.width(this.parent.$el.width()),
                    this.$el.show(),
                    this.trigger("dropdown:show")
                },
                n.prototype.clear_suggestions = function (e) {
                    return this.current_keyword = "",
                    this.$el.empty(),
                    this.hide(),
                    null != e ? e.stop() : void 0
                },
                n
            }(Backbone.View)
    }.call(this),


function () {
        var e, t = function (e, t) {
            return function () {
                return e.apply(t, arguments)
            }
        },
            i = {}.hasOwnProperty,
            n = function (e, t) {
                function n() {
                    this.constructor = e
                }
                for (var s in t) i.call(t, s) && (e[s] = t[s]);
                return n.prototype = t.prototype,
                e.prototype = new n,
                e.__super__ = t.prototype,
                e
            };
        PxApp.Models.Tag = function (i) {
                function s() {
                    return this.isNew = t(this.isNew, this),
                    this.url = t(this.url, this),
                    e = s.__super__.constructor.apply(this, arguments)
                }
                return n(s, i),
                s.prototype.url = function () {
                    var e, t;
                    return e = this.taggable_model.url().split("?"),
                    t = e.length > 1 ? e[1] : "",
                    "" + e[0] + "/tags?" + t + "tags=" + this.attributes.name
                },
                s.prototype.initialize = function (e, t) {
                    return this.taggable_model = t.taggable_model
                },
                s.prototype.isNew = function () {
                    return !1
                },
                s
            }(Backbone.Model)
    }.call(this),


function () {
        var e, t = function (e, t) {
            return function () {
                return e.apply(t, arguments)
            }
        },
            i = {}.hasOwnProperty,
            n = function (e, t) {
                function n() {
                    this.constructor = e
                }
                for (var s in t) i.call(t, s) && (e[s] = t[s]);
                return n.prototype = t.prototype,
                e.prototype = new n,
                e.__super__ = t.prototype,
                e
            };
        PxApp.Collections.Tags = function (i) {
                function s() {
                    return this["delete"] = t(this["delete"], this),
                    this.url = t(this.url, this),
                    e = s.__super__.constructor.apply(this, arguments)
                }
                return n(s, i),
                s.prototype.model = PxApp.Models.Tag,
                s.prototype.url = function () {
                    return "/photos/" + this.photo.id + "/tags"
                },
                s.prototype.initialize = function (e, t) {
                    return this.photo = t.photo
                },
                s.prototype["delete"] = function (e) {
                    var t, i, n, s, a;
                    for (i = this.where({
                        name: e
                    }), this.remove(i), a = [], n = 0, s = i.length; s > n; n++) t = i[n],
                    a.push(t.destroy());
                    return a
                },
                s
            }(Backbone.Collection)
    }.call(this),


function () {
        var e, t = function (e, t) {
            return function () {
                return e.apply(t, arguments)
            }
        },
            i = {}.hasOwnProperty,
            n = function (e, t) {
                function n() {
                    this.constructor = e
                }
                for (var s in t) i.call(t, s) && (e[s] = t[s]);
                return n.prototype = t.prototype,
                e.prototype = new n,
                e.__super__ = t.prototype,
                e
            };
        PxApp.Collections.SetTags = function (i) {
                function s() {
                    return this.url = t(this.url, this),
                    e = s.__super__.constructor.apply(this, arguments)
                }
                return n(s, i),
                s.prototype.url = function () {
                    return "/collections/" + this.set.id + "/tags?kind=2"
                },
                s.prototype.initialize = function (e, t) {
                    return this.set = t.set
                },
                s
            }(PxApp.Collections.Tags)
    }.call(this),


function () {
        var e, t = {}.hasOwnProperty,
            i = function (e, i) {
                function n() {
                    this.constructor = e
                }
                for (var s in i) t.call(i, s) && (e[s] = i[s]);
                return n.prototype = i.prototype,
                e.prototype = new n,
                e.__super__ = i.prototype,
                e
            };
        PxApp.Collections.TagSuggestions = function (t) {
                function n() {
                    return e = n.__super__.constructor.apply(this, arguments)
                }
                var s;
                return i(n, t),
                n.prototype.model = PxApp.Models.Tag,
                s = 500,
                n.prototype.url = function () {
                    var e;
                    return e = this.user_id ? "/users/" + this.user_id + "/tags/top" : "/tags/top",
                    "" + e + "?size=" + this.num_tags
                },
                n.prototype.initialize = function (e, t) {
                    var i;
                    return this.user_id = null != t ? t.user_id : void 0,
                    this.num_tags = Number(null != t ? t.num_tags : void 0),
                    0 < (i = this.num_tags) && 1e3 > i ? void 0 : this.num_tags = s
                },
                n.prototype.parse = function (e) {
                    var t, i, n, s, a;
                    for (s = e.tags, a = [], i = 0, n = s.length; n > i; i++) t = s[i],
                    a.push(new PxApp.Models.Tag({
                        name: t
                    }, {
                        taggable_model: null
                    }));
                    return a
                },
                n
            }(Backbone.Collection)
    }.call(this),


function () {}.call(this);