% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Hãy Ca Ngợi Chúa" }
  composer = "Tv. 102"
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
nhacPhienKhucSop = \relative c' {
  \autoPageBreaksOff
  \partial 4. e8 d c |
  f8. f16 e8 d |
  g4 r8 g |
  c c r a |
  d d4 c8 |
  b2 |
  r8 e, d c |
  f8. f16 e8 d |
  g4 r8 g |
  c c r a |
  d d4 b8 |
  c2 ~ |
  c4 r8 \bar "||" \break
  
  c,8 |
  g'8. g16 g8 g |
  e a4 c8 |
  b8. g16 a8 f |
  e2 ~ |
  e4 r8 e' |
  
  \pageBreak
  
  d8. b16 b8 c |
  d a4 a8 |
  g8. e'16 e8 d |
  b c ~ c4 ~ |
  c8 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  e8 d c |
  f8. f16 e8 d |
  g4 r8 f |
  e e r g |
  fs fs4 fs8 |
  g2 |
  r8 e d c |
  f8. f16 e8 d |
  g4 r8 f |
  e e r c |
  f f4 g8 |
  e2 ~ |
  e4 r8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \stanzaReminderOff
  \set stanza = "ĐK:"
  Hãy ca ngợi Chúa, hỡi linh hồn tôi,
  Toàn thân tôi, nào hát kính Danh Ngài.
  Hãy ca ngợi Chúa, hỡi linh hồn tôi,
  Đừng quên đi lộc phúc Chúa đà ban.
  \stanzaReminderOn
  <<
    {
      \set stanza = "1."
      Ngài tha cho ngươi muôn tội lỗi,
      chữa ngươi khỏi các tật nguyền,
      Cứu ngươi khỏi vùi sâu đáy huyệt,
      ân lộc nghĩa thiết bao bọc ngươi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Ngài ban cho ngươi luôn hạnh phúc,
	    tuổi xuân như cánh chim bằng.
	    Chúa luôn hằng xử phân chính trực,
	    ai bị ức hiếp cho giải oan.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Ngài cho Mô -- sê hay đường lối,
	    Ít -- ra -- en thấy công trình,
	    Chúa luôn giầu tình sâu nghĩa nặng,
	    không hề mãi mãi nuôi hờn căm.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Ngài không theo như ta lầm lỗi,
	    xét soi trả báo tội tình.
	    Chúa thương kẻ nào tôn kính Ngài,
	    ân tình bát ngát cung trời cao.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Ngài quăng ta xa muôn tội lỗi,
	    giống phương đông cách phương đoài.
	    Chúa thương kẻ thành tín
	    khác gì cha hiền vẫn mến thương đoàn con.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
      \override Lyrics.LyricText.font-shape = #'italic
	    Nặn nên thân ta do bùn đất,
	    Chúa sao không nhớ không tường.
	    Tháng năm phận phù sinh
	    ví tựa hoa đồng sáng thắm nhưng chiều phai.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "7."
	    Nào ai trung kiên tôn thờ Chúa,
	    phúc ân muôn kiếp muôn đời.
	    Giữ y mệnh lệnh, giao ước Ngài,
	    miêu duệ Chúa cũng minh xử cho.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "8."
      \override Lyrics.LyricText.font-shape = #'italic
	    Đặt ngai uy linh trên trời thẳm,
	    Chúa trông coi hết mọi loài.
	    Hỡi muôn bậc hùng anh lẫm liệt,
	    thiên thần lớp lớp ca tụng đi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "9."
	    Cùng muôn cơ binh ca tụng Chúa,
	    chúng sinh do Chúa tạo thành.
	    Khắp nơi trực thuộc vương quốc Ngài.
	    Chung lời hát kính đi, hồn ơi.
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
  system-system-spacing = #'((basic-distance . 0.1) (padding . 2))
  ragged-bottom = ##t
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
    \override Lyrics.LyricSpace.minimum-distance = #1.5
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
