% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Thượng Đế Muôn Loài" }
  composer = "Hc. 36,1-5.10-13"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  f4. g8 |
  a4 \tuplet 3/2 { g8 bf a } |
  d,2 |
  d4. e16 c |
  f8 e a16 (bf) a8 |
  g4 r8 g16 f |
  bf8 bf bf bf16 a |
  c4. c16 d |
  bf8 g bf a |
  d,4. d16 e |
  <<
    {
      \voiceOne
      e8
    }
    \new Voice = "beSop" {
      \voiceTwo
      \once \override NoteColumn.force-hshift = #1.2
      \parenthesize
      c
    }
  >>
  \oneVoice
  c d
  <<
    {
      \voiceOne
      e
    }
    \new Voice = "beSop" {
      \voiceTwo
      \once \override NoteColumn.force-hshift = #-1
      \parenthesize
      g
    }
  >>
  \oneVoice
  f4 r8 \bar "||"
  
  <> \tweak extra-offset #'(-6 . -2.5) _\markup { \bold "ĐK:" }
  c'8 |
  c4 \tuplet 3/2 { d8 a bf } |
  c8. a16 \tuplet 3/2 { f8 f f } |
  g4 \tuplet 3/2 { e8 f g } |
  a4 r8 f |
  g4. a8 |
  d,8. c16 \tuplet 3/2 { a'8 bf a } |
  g4. g16 (a) |
  f2 \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  R2*11
  r4.
  a8 |
  a4 \tuplet 3/2 { bf8 f g } |
  a8. f16 \tuplet 3/2 { d8 d d } |
  e4 \tuplet 3/2 { c8 d e } |
  f4 r8 d |
  c4. c8 |
  bf8. a16 \tuplet 3/2 { f'8 g f } |
  e4. e8 |
  f2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Lạy Thiên Chúa, Thượng Đế muôn loài,
      Xin dủ tình thương nhìn đến chúng con,
      Xin làm cho chư dân tôn sợ Chúa,
      Giơ cánh tay đè xuống dân ngoại
      cho chúng biết Ngài thực quyền uy.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Họ xem thấy Ngài rất thánh thiện
	    trong cách Ngài cư xử với chúng con,
	    Thì nay cho con dân đây được thấy
	    Thiên Chúa cao cả đến muôn trùng
	    trong cách \markup { \italic \underline "Ngài" }
	    xử trị chư dân.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Nguyện cho chúng rầy cũng am tường
	    như chính đoàn con từng biết xưa nay,
	    Không thần minh đâu cao quang ngoài Chúa,
	    Xin cánh tay hiển hách uy hùng
	    cho tái diễn điềm lạ
	    \markup { \italic \underline "dấu" } thiêng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Nhà Gia -- cóp, nguyện Chúa quy tụ
	    cho chiếm lại gia nghiệp thuở ban sơ,
	    Xin dủ thương dân riêng Ít -- ra -- en,
	    Xưa Chúa nhận làm trưởng nam Ngài,
	    thương đoái tới Giê -- ru -- sa -- lem.
    }
  >>
  %\set stanza = " ĐK:"
  \set stanza = ""
  Xin cho khắp cả Si -- on vang dội
  lời truyền rao kỳ công của Chúa,
  Và cho thánh điện rực rỡ ánh vinh quang của Ngài.
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
  page-count = 1
}

TongNhip = {
  \key f \major \time 2/4
  \set Timing.beamExceptions = #'()
  \set Timing.baseMoment = #(ly:make-moment 1/4)
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
     (padding . 1)
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
                      (ly:pointer-group-interface::add-grob text
'side-support-elements syllable))
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
% kết thúc mã nguồn

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
    \override Lyrics.LyricSpace.minimum-distance = #0.6
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
