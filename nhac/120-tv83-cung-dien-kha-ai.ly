% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Cung Điện Khả Ái" }
  composer = "Tv. 83"
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
  b4. c16 b |
  a4 fs8 a |
  g4. g16 e |
  d4 r8 d |
  b'8. b16 c8 c |
  b a4 g8 |
  c8. c16 b8 b |
  \slashedGrace { b16 ( } c8) d ~ d4 |
  d8. d16 d8 b |
  c d a a |
  c b g4 ~ |
  g8 a fs (e) |
  d4. d8 |
  b' (c16 b) a8 a |
  d2 ~ |
  d4 \bar "||"
  
  a8 a |
  \slashedGrace { fs16 ( } g8) e16 e g8 a |
  b4 d8 g, |
  a e16 e fs (e) d8 |
  g2 |
  r8 g fs g |
  b2 ~ |
  b8 g c b |
  a4 a8 a |
  c8. a16 d8 b16 (a) |
  g2 \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  g4. a16 g |
  fs4 d8 fs |
  e4. e16 cs |
  d4 r8 d |
  g8. g16 a8 a |
  g fs4 e8 |
  a8. a16 g8 g |
  \slashedGrace { g16 ( } a8) b8 ~ b4 |
  b8. b16 b8 g |
  a g fs fs |
  a g e4 ~ |
  e8 e d (cs) |
  d4. d8 |
  g4 g8 g |
  fs2 ~ |
  fs4
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \stanzaReminderOff
  \set stanza = "ĐK:"
  Ôi Chúa thiên binh, khả ái thay cung điện Ngài,
  Hồn con mong ước tới tiêu hao
  được bước tới tiền đình nhà Chúa.
  Đây thân con cùng cả tấc dạ
  rộn rã reo mừng hướng lên Ngài
  lạy Chúa Trời hằng sống,
  \stanzaReminderOn
  <<
    {
      \set stanza = "1."
      Ngay chim sẽ còn tìm ra mái ấm,
      Cánh nhạn kia còn làm tổ đặt con
      Bên bàn thờ Chúa lạy Chúa thiên binh,
      Ngài là Vua, là Chúa con thờ.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Bao vinh dự được ngụ trong cung thánh,
	    Cất lời ca tụng mừng Chúa rền vang.
	    Tin nhận ở Chúa là sức oai phong,
	    mộng hành hương ủ ấp bên lòng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Qua hoang địa, trào vọt ra khe suối,
	    Khiến đổ mưa tràn trề những hồng ân,
	    Băng đồi vượt suối về núi Si -- on,
	    Họ mừng vui diện kiến Chúa Trời.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Xin thương nhận từng lời con kêu khấn,
	    Chúa quyền linh xin nghe tiếng nài van,
	    Ôi lạy Thiên Chúa là thuẫn khiên con,
	    Hãy nhìn coi người Chúa xức dầu.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Cho con được ở cổng đền Thiên Chúa,
	    Vẫn con hơn trong dinh lũ tàn hung,
	    Một ngày được sống ở thánh cung thôi,
	    Ngàn ngày nơi nào khác đâu bằng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
      \override Lyrics.LyricText.font-shape = #'italic
	    Ban ân huệ và hiển vinh khôn sánh,
	    Chúa thực như Vầng Hồng mãi rạng soi,
	    Ai người ngay chính Ngài chở che luôn,
	    Và chẳng khi từ chối ơn lành.
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
  %page-count = #1
}

TongNhip = {
  \key g \major \time 2/4
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
    \override Lyrics.LyricSpace.minimum-distance = #1.5
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
