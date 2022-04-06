% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Trong Đức Kitô" }
  composer = "Ep. 1,3-10"
  tagline = ##f
}

% mã nguồn cho những chức năng chưa hỗ trợ trong phiên bản lilypond hiện tại
% cung cấp bởi cộng đồng lilypond khi gửi email đến lilypond-user@gnu.org
% Đổi kích thước nốt cho bè phụ
notBePhu =
#(define-music-function (font-size music) (number? ly:music?)
   (for-some-music
     (lambda (m)
       (if (music-is-of-type? m 'rhythmic-event)
           (begin
             (set! (ly:music-property m 'tweaks)
                   (cons `(font-size . ,font-size)
                         (ly:music-property m 'tweaks)))
             #t)
           #f))
     music)
   music)

% in số phiên khúc trên mỗi dòng
#(define (add-grob-definition grob-name grob-entry)
     (set! all-grob-descriptions
           (cons ((@@ (lily) completize-grob-entry)
                  (cons grob-name grob-entry))
                 all-grob-descriptions)))

#(add-grob-definition
    'StanzaNumberSpanner
    `((direction . ,LEFT)
      (font-series . bold)
      (padding . 1.0)
      (side-axis . ,X)
      (stencil . ,ly:text-interface::print)
      (X-offset . ,ly:side-position-interface::x-aligned-side)
      (Y-extent . ,grob::always-Y-extent-from-stencil)
      (meta . ((class . Spanner)
               (interfaces . (font-interface
                              side-position-interface
                              stanza-number-interface
                              text-interface))))))

\layout {
    \context {
      \Global
      \grobdescriptions #all-grob-descriptions
    }
    \context {
      \Score
      \remove Stanza_number_align_engraver
      \consists
        #(lambda (context)
           (let ((texts '())
                 (syllables '()))
             (make-engraver
              (acknowledgers
               ((stanza-number-interface engraver grob source-engraver)
                  (set! texts (cons grob texts)))
               ((lyric-syllable-interface engraver grob source-engraver)
                  (set! syllables (cons grob syllables))))
              ((stop-translation-timestep engraver)
                 (for-each
                  (lambda (text)
                    (for-each
                     (lambda (syllable)
                       (ly:pointer-group-interface::add-grob
                        text
                        'side-support-elements
                        syllable))
                     syllables))
                  texts)
                 (set! syllables '())))))
    }
    \context {
      \Lyrics
      \remove Stanza_number_engraver
      \consists
        #(lambda (context)
           (let ((text #f)
                 (last-stanza #f))
             (make-engraver
              ((process-music engraver)
                 (let ((stanza (ly:context-property context 'stanza #f)))
                   (if (and stanza (not (equal? stanza last-stanza)))
                       (let ((column (ly:context-property context
'currentCommandColumn)))
                         (set! last-stanza stanza)
                         (if text
                             (ly:spanner-set-bound! text RIGHT column))
                         (set! text (ly:engraver-make-grob engraver
'StanzaNumberSpanner '()))
                         (ly:grob-set-property! text 'text stanza)
                         (ly:spanner-set-bound! text LEFT column)))))
              ((finalize engraver)
                 (if text
                     (let ((column (ly:context-property context
'currentCommandColumn)))
                       (ly:spanner-set-bound! text RIGHT column)))))))
      \override StanzaNumberSpanner.horizon-padding = 10000
    }
}

stanzaReminderOff =
  \temporary \override StanzaNumberSpanner.after-line-breaking =
     #(lambda (grob)
        ;; Can be replaced with (not (first-broken-spanner? grob)) in 2.23.
        (if (let ((siblings (ly:spanner-broken-into (ly:grob-original grob))))
              (and (pair? siblings)
                   (not (eq? grob (car siblings)))))
            (ly:grob-suicide! grob)))

stanzaReminderOn = \undo \stanzaReminderOff
% kết thúc mã nguồn

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 8 g8 |
  c,4. d8 |
  e4 e8 d |
  a' g g g |
  g4 c8 c |
  b2 ~ |
  b8 b c b |
  a4 a8 b |
  g8. g16 e'8 e |
  e16 (f) e8 d4 |
  d8. d16
  \afterGrace a8 ({
    \override Flag.stroke-style = #"grace"
    c16)}
  \revert Flag.stroke-style
  a8 |
  g8. b16 d8 d |
  c2 \bar "|."
  
  e,4 f8 e |
  d4 d8 d |
  g4. a8 |
  f8 e d g |
  c,2 ~ |
  c4 r8 c |
  f4 f8 e |
  d4. d16 c |
  g'8 g e a |
  f4 d8 d |
  g4. g8 |
  c,4 r8 \bar "||"
}

nhacPhienKhucAlto = \relative c'' {
  g8 |
  c,4. d8 |
  e4 e8 d |
  a' g f f |
  e4 e8 e |
  g2 ~ |
  g8 g a e |
  f4 f8 g |
  e8. c16 c'8 c |
  c16 (d) c8 g4 |
  fs8. fs16 f!8 [f] |
  e8. d16 f8 f |
  e2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \stanzaReminderOff
  \set stanza = "ĐK:"
  Chúc tụng Thiên Chúa, Thân Phụ Đức Giê -- su Ki -- tô,
  Chúa chúng ta,
  Trong Đức Ki -- tô, tự cõi trời Ngài đã giáng phúc thi ân
  Cho ta hưởng muôn vàn ân phúc Thánh Linh.
  \stanzaReminderOn
  <<
    {
      \set stanza = "1."
      Trong Đức Ki -- tô, Ngài chọn ta
      trước khi tạo thành vũ trụ.
      Để trước thánh nhan Ngài
      ta trở nên tinh tuyền thánh thiện
      nhờ tình thương của Ngài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Theo Chúa tiên định,
	    vì tình thương đã cho ta làm nghĩa tử,
	    Nhờ chính Đức Ki -- tô,
	    ta ngợi khen ân sủng rạng ngời
	    mà Ngài cho lãnh nhận.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Do máu con Ngài đã đổ ra,
	    chúng ta nay được cứu độ,
	    Được miễn thứ tội tình
	    theo hồng ân khôn lường của Ngài
	    rầy tặng ta dẫy đầy.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Do ý nhiệm mầu mà rầy ta thấu tỏ
	    chương trình của Ngài,
	    Từ trước đã an bài
	    theo sự khôn ngoan lịch lãm Ngài,
	    vì tình thương ấn định.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Trong Đức Ki -- tô Ngài gộp thâu
	    tất cả vạn vật đất trời,
	    Là lúc Chúa an bài
	    Cho thời gian viên thành mãn hồi,
	    Ngài thực thi ý định.
    }
  >>
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 3\mm
  bottom-margin = 3\mm
  left-margin = 3\mm
  right-margin = 3\mm
  indent = #0
  #(define fonts
	 (make-pango-font-tree "Deja Vu Serif Condensed"
	 		       "Deja Vu Serif Condensed"
			       "Deja Vu Serif Condensed"
			       (/ 20 20)))
  print-page-number = ##f
  system-system-spacing = #'((basic-distance . 0.1) (padding . 2.5))
  page-count = 1
}

TongNhip = {
  \key c \major \time 2/4
  \set Timing.beamExceptions = #'()
  \set Timing.baseMoment = #(ly:make-moment 1/4)
}

\score {
  \new ChoirStaff <<
    \new Staff \with {
        \consists "Merge_rests_engraver"
        printPartCombineTexts = ##f
      }
      <<
      \new Voice \TongNhip \partCombine 
        \nhacPhienKhucSop
        \notBePhu -1 { \nhacPhienKhucAlto }
      \new NullVoice = beSop \nhacPhienKhucSop
      \new Lyrics \lyricsto beSop \loiPhienKhucSop
      >>
  >>
  \layout {
    \override Lyrics.LyricSpace.minimum-distance = #1
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
