% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Hãy Nhiệt Liệt Tung Hô" }
  composer = "Tb. 13,10-18"
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
  c8. f16 f8 f |
  f4. e8 |
  d4 \tuplet 3/2 { bf'8 g g } |
  a4 e8 f16 (g) |
  c,8. c'16 \tuplet 3/2 { bf8 bf bf } |
  bf4 r8 bf16 g |
  a4. e8 |
  e4 \tuplet 3/2 { f8 g f } |
  d8. d16 \tuplet 3/2 { c8 e g } |
  f4. e16 f |
  d8 c4 f16 (g) |
  a4 r8 \bar "||" \break
  
  a16 f |
  f8 g g a |
  bf4 bf8 a |
  g8. g16 g8 d' ~ |
  d d b! b |
  c4 r8 g16 bf |
  a8 e f g |
  c,4 f8 e |
  f8. g16 a8 bf ~ |
  bf bf d, c |
  f2 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  R2*11
  r4.
  f16 c |
  d8 e e f |
  g4 g8 f |
  e8. e16 e8 f ~ |
  f f g g |
  e4 r8 e16 g |
  f8 c d bf |
  a4 a8 c |
  d8. e16 f8 d ~ |
  d c bf bf |
  a2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Tại Giê -- ru -- sa -- lem
      mọi người hãy tuyên xưng Chúa và nói rằng:
      Hỡi Giê -- ru -- sa -- lem,
      Chúa phạt ngươi vì việc con cái ngươi làm,
      nhưng rồi lại xót thương
      vì miêu duệ người công chính.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Để nơi ngươi qua muôn thế hệ
	    Chúa sẽ làm cho kẻ lưu đầy nếm say bao hân hoan,
	    Kẻ lầm than được Ngài thương mến muôn vàn
	    cho bừng lên ánh quang
	    soi sáng cả mười phương đất.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Và dân cư muôn phương trăm họ sẽ về
	    tụng ca cùng lễ vật tiến dâng vua cao quang,
	    Đến ngàn năm, người người hoan chúc vui mừng
	    lưu truyền muôn kiếp sau
	    vì Chúa thương chọn ngươi đó.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Nào vui lên đi ngươi
	    để mừng những đoàn tử tôn người chính trực
	    đến vây chung quanh ngươi,
	    chúc tụng Chúa ngự trị muôn kiếp muôn đời,
	    ôi thực vinh phúc thay
	    cho kẻ thương phận ngươi mãi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Hồn tôi ơi reo lên ca mừng Chúa Trời
	    là Vua, Ngài tái tạo khắp Giê -- ru -- sa -- lem,
	    Thánh điện nay trường tồn,
	    bao cánh cửa thành cẩn toàn ngọc bích lam,
	    tường lũy xây bằng đá quý.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
      \override Lyrics.LyricText.font-shape = #'italic
	    Ngọc với đá Sa -- phia trải dài khắp nẻo đường đi
	    và cửa thành trổi vang câu hoan ca,
	    Các cửa nay hợp lời:
	    Al -- le -- lu -- ia
	    ca mừng Chúa Ích -- diên,
	    nguyện hiển danh Ngài muôn kiếp.
    }
  >>
  \stanzaReminderOff
  \set stanza = "ĐK:"
  Hãy nhiệt liệt tung hô Thiên Chúa,
  Tán dương Ngài là hoàng đế thống trị ngàn thu,
  Để thánh đô được xây cất lại
  Nơi thành ngươi trong không khí nào nhiệt mừng vui.
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
  page-count = 2
}

TongNhip = {
  \key f \major \time 2/4
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
    \override Lyrics.LyricSpace.minimum-distance = #0.8
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
