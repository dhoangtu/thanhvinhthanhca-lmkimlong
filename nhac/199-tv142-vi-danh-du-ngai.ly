% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Vì Danh Dự Ngài" }
  composer = "Tv. 142"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 8 d,8 |
  bf'4 \tuplet 3/2 { a8 a g } |
  a4. bf16 (a) |
  g4 \tuplet 3/2 { d8 bf' g } |
  c4. c8 |
  c4 \tuplet 3/2 { bf8 a c } |
  d2 |
  c4 \tuplet 3/2 { d8 bf g } |
  a4. bf8 |
  a4 \slashedGrace { f16 ( }
    \tuplet 3/2 { g8) d d } |
  bf'4. a8 |
  g2 ~ |
  \partial 4. g4 r8 \bar "||" \break
  
  \set Staff.explicitKeySignatureVisibility = #end-of-line-invisible
  \set Staff.printKeyCancellation = ##f
  \key g \major
  <> \tweak extra-offset #'(-6.5 . -1.8) _\markup { \bold "ĐK:" }
  \partial 8 d8 |
  b'4 \tuplet 3/2 { g8 a e } |
  d4. b'16 b |
  b4. a8 |
  c4 \tuplet 3/2 { b8 b c } |
  d4. d16 e |
  d8 c a fs |
  g2 ~ |
  g4 r8 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  r8 |
  R2*11
  r4.
  d8 |
  g4 \tuplet 3/2 { e8 d c } |
  d4. g16 g |
  g4. d8 |
  e4 \tuplet 3/2 { g8 g a } |
  b4. bf16 c |
  b8 a d, d |
  b2 ~ |
  b4 r8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Lạy Chúa xin nghe lời con khấn nguyện,
      nhận rõ lời con than van bởi Ngài trung tín.
      Xin đáp lại lời con Chúa ơi,
      bởi Ngài thực rất công minh.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Ngài chớ đưa thân này ra xử trị,
	    vì trước Thần Nhan ai đâu hẳn là công chính,
	    Bao ác nhân tìm con tiến công,
	    đẩy vào ngục tối thiên thu.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Ngày cũ con đây hằng luôn tưởng niệm
	    và nhớ lại bao uy công do Ngài tạo tác.
	    Đây cánh tay vọng lên Chúa luôn,
	    mảnh hồn tựa đất khô ran.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Lạy Chúa hơi con giờ đây đã tàn,
	    nguyện Chúa dủ thương mau mau nhận lời kêu khấn.
	    Xin chớ ẩn mặt đi kẻo con tựa bị vùi dưới hố sâu.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Từ sớm cho con nghiệm say phúc lộc
	    vì suốt đời con khôn ngơi cậy nhờ nơi Chúa,
	    Con vẫn nâng hồn lên Chúa đây,
	    nguyện Ngài chỉ lối cho con.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
      \override Lyrics.LyricText.font-shape = #'italic
	    Ngài cứu thân con khỏi tay kẻ thù
	    và dẫn dụ con luôn luôn tuân hành thiên ý,
	    Trên đất phẳng dìu con bước đi,
	    bởi Ngài thần trí cao minh.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "7."
	    Tình Chúa yêu thương ngàn năm vững bền,
	    nguyện hãy thẳng tay tru di kẻ thù gian ác,
	    Ai nhiễu hại bầy tôi Chúa đây,
	    nguyện Ngài diệt hết đi luôn.
    }
  >>
  %\set stanza = "ĐK:"
  \set stanza = ""
  Lạy Chúa, vì danh dự Ngài,
  xin cho con được sống,
  Vì Ngài công chính,
  xin cứu con khỏi cơn hiểm nghèo.
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 10\mm
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
  system-system-spacing = #'((basic-distance . 0.1) (padding . 3.5))
  ragged-bottom = ##t
}

TongNhip = {
  \key bf \major \time 2/4
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
    \override Lyrics.LyricSpace.minimum-distance = #1.5
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
